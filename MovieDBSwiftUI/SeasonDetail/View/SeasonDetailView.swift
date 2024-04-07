//
//  SeasonDetailView.swift
//  MovieDBSwiftUI
//
//  Created by Muhammad Irfan on 06/04/2024.
//

import SwiftUI

struct SeasonDetailView: View {

  @ObservedObject var viewModel: SeasonDetailViewModel
  @EnvironmentObject var router: Router

  var body: some View {
    VStack {
      List() {
        if let episodes = $viewModel.episodes.wrappedValue {
          ForEach(episodes, id: \.id) { episode in
            SeasonView(episode: episode)
              .onTapGesture {
                router.navigate(to: .episodeDetail(viewModel: EpisodeDetailViewModel(episode: episode)))
              }
          }
          .listRowBackground(Color.gray.opacity(0.1))
          .listRowSeparator(.visible, edges: .bottom)
        }
      }
      .listRowSpacing(10)
      .listStyle(.plain)
    }
    .onAppear {
    }
  }
}

struct SeasonView: View {
    let episode: Episode

    var body: some View {
        HStack {
          AsyncImage(url: URL(string: episode.getImagePath() )) { image in
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

          Text(episode.name ?? "")
            .foregroundColor(.white)
        }
    }
}


#Preview {
    SeasonDetailView(viewModel: SeasonDetailViewModel(service: SeasonDetailService(seriesId: 1, seasonNumber: 0)))
}
