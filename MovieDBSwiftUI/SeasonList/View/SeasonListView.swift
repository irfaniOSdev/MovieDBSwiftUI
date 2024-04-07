//
//  SeasonListView.swift
//  MovieDBSwiftUI
//
//  Created by Muhammad Irfan on 07/04/2024.
//

import SwiftUI

struct SeasonListView: View {

  @ObservedObject var viewModel = SeasonListViewModel()

  @EnvironmentObject var router: Router

    var body: some View {
      
      VStack(alignment: .leading, spacing: 10) {
        Text("Popular Seasons")
          .multilineTextAlignment(.leading)
          .font(.largeTitle)
          .foregroundColor(.white)

        List {
          if let seriesList = $viewModel.model.wrappedValue?.results {
            ForEach(seriesList, id: \.id) { series in
              SeasonListRow(series: series)
                .id(series.id)
                .onAppear {
                  if series == seriesList.last {
                    viewModel.fetchSeasonInfo()
                  }
                }
                .onTapGesture {
                  let service = ShowDetailService(seriesId: series.id)
                  let viewModel = ShowDetailViewModel(service: service)
                  router.navigate(to: .showDetail(viewModel: viewModel))
                }
            }
            .listRowBackground(Color.gray.opacity(0.1))
            .listRowSeparator(.visible, edges: .bottom)
          }
        }
        .listRowSpacing(10)
        .listStyle(.plain)
      }
      .padding()
      .background(Color.black)
      .onLoad {
        viewModel.fetchSeasonInfo()
      }
      .alert(isPresented: $viewModel.showAlert) {
        Alert(title: Text("Error"), message: Text($viewModel.error.wrappedValue?.localizedDescription ?? ""), dismissButton: .default(Text("OK")))
      }
    }
}

struct SeasonListRow: View {
    let series: Series
    var body: some View {
        HStack {
          AsyncImage(url: URL(string: series.getImagePath() )) { image in
            image
              .resizable()
              .aspectRatio(contentMode: .fit)
          } placeholder: {
            Image(systemName: "photo")
              .resizable()
              .foregroundColor(.gray)
              .aspectRatio(contentMode: .fit)
              .frame(width: 100, height: 100)
              .padding()
          }
          .frame(width: 150, height: 150)
          .padding(.leading, 0)

          Text(series.name ?? "")
            .foregroundColor(.white)
            .font(.headline)
        }
    }
}

#Preview {
    SeasonListView()
}
