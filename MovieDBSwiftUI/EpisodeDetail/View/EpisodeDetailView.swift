//
//  EpisodeDetailView.swift
//  MovieDBSwiftUI
//
//  Created by Muhammad Irfan on 07/04/2024.
//

import SwiftUI

struct EpisodeDetailView: View {
  let viewModel: EpisodeDetailViewModel
  @EnvironmentObject var router: Router

    var body: some View {
      VStack {
        GeometryReader { geometery in
          ScrollView {
            VStack(spacing: 20) {
              AsyncImage(url: URL(string: viewModel.getImagePath() )) { image in
                image
                  .resizable()
                  .aspectRatio(contentMode: .fit)
              } placeholder: {

              }
              .frame(width: geometery.size.width, height: 200)
              .padding(.leading, 0)

              HStack {
                ButtonView(text: "Play", backgroundColor: .orange) {
                  router.navigate(to: .videoPlayer)
                }
                .frame(maxHeight: 50)

                ButtonView(text: "Trailer", backgroundColor: .gray) {
                  router.navigate(to: .videoPlayer)
                }
                .frame(maxHeight: 50)
              }

              Text(viewModel.getOverView())
                .multilineTextAlignment(.leading)
                .font(.subheadline)
                .foregroundColor(.white)
            }
          }
        }
        .background(Color.black)
      }
      .navigationBarItems( leading: Button(action: { router.back() }) {
                Image(systemName: "arrow.left")
                    .foregroundColor(.white)
                    .padding(.leading, 0)
       })

    }
}

struct ButtonView: View {
    let text: String
    let backgroundColor: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(text)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(backgroundColor)
                .cornerRadius(10)
        }
        .padding(.horizontal)
    }
}

#Preview {
    EpisodeDetailView(viewModel: EpisodeDetailViewModel(episode: Episode(episodeNumber: 0, id: 0, name: "Some Movie", overview: "Some movie overview", seasonNumber: 1, stillPath: nil)))
}
