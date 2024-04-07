//
//  ContentView.swift
//  MovieDBSwiftUI
//
//  Created by Muhammad Irfan on 04/04/2024.
//

import SwiftUI

struct ContentView: View {

  @StateObject var router = Router()

  var body: some View {

    NavigationView {
      Group {
        switch router.currentDestination {
        case .seasonList:
          SeasonListView()
            .environmentObject(router)
        case .showDetail(let viewModel):
          ShowDetailView(viewModel: viewModel)
            .environmentObject(router)
        case .episodeDetail(let viewModel):
          EpisodeDetailView(viewModel: viewModel)
            .environmentObject(router)
        case .videoPlayer:
          VideoPlayerView()
            .environmentObject(router)
        }
      }
      .environmentObject(router)
    }
  }
}

#Preview {
    ContentView()
}
