//
//  ShowDetailView.swift
//  MovieDBSwiftUI
//
//  Created by Muhammad Irfan on 06/04/2024.
//

import SwiftUI

struct ShowDetailView: View {

  @ObservedObject var viewModel: ShowDetailViewModel

  @EnvironmentObject var router: Router

  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
        VStack(alignment: .leading, spacing: 10) {
          Text(viewModel.getName())
            .multilineTextAlignment(.leading)
            .font(.title)
            .foregroundColor(.white)

          Text(viewModel.getOverView())
            .multilineTextAlignment(.leading)
            .font(.subheadline)
            .foregroundColor(.white)
        }.padding(.top, 0)

        ScrollView(.horizontal, showsIndicators: false) {
          HStack(spacing: 0) {
            if let seasons = $viewModel.model.wrappedValue?.seasons {
              ForEach(0..<seasons.count, id: \.self) { index in
                Button(action: {
                  viewModel.selectedTab = index
                }) {
                  tabCustomView(season: seasons[index])
                    .overlay(viewModel.selectedTab == index ? bottomBar() : nil, alignment: .bottom)
                }
              }
            }
          }
        }

        VStack {
          TabView(selection: $viewModel.selectedTab) {
            if let seasons = $viewModel.model.wrappedValue?.seasons {
              ForEach(seasons.indices, id: \.self) { index in       
                if viewModel.selectedTab == index {
                  let service = SeasonDetailService(seriesId: viewModel.model?.id ?? 0, seasonNumber: seasons[index].seasonNumber ?? 0)
                  let detailViewModel = SeasonDetailViewModel(service: service)
                  SeasonDetailView(viewModel: detailViewModel)
                } else {
                  EmptyView()
                }
              }
            }
          }
          .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
          .padding(.top, 0)
        }
    }
    .padding(.vertical, 0)
    .padding(.horizontal, 10)
    .background(Color.black)
    .navigationBarItems( leading: Button(action: { router.back() }) {
              Image(systemName: "arrow.left")
                  .foregroundColor(.white)
                  .padding(.leading, 0)
     })
    .onAppear() {
      viewModel.fetchShowInfo()
    }
    .alert(isPresented: $viewModel.showAlert) {
      Alert(title: Text("Error"), message: Text($viewModel.error.wrappedValue?.localizedDescription ?? ""), dismissButton: .default(Text("OK")))
    }
  }

  func bottomBar() -> some View {
    Rectangle()
      .fill(Color.white)
      .frame(height: 2)
      .padding(.horizontal, 20)
  }

  func tabCustomView(season: Season)-> some View {
    HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20) {
      Text(season.name ?? "")
        .foregroundColor(.white)
        .font(.headline)
        .padding(.vertical, 10)
        .padding(.horizontal, 20)

      Divider().frame(height: 40)
        .background(Color.gray)
    }
  }
}

#Preview {
    ShowDetailView(viewModel: ShowDetailViewModel(service: ShowDetailService(seriesId: 1)))
}
