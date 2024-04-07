//
//  VideoPlayerView.swift
//  MovieDBSwiftUI
//
//  Created by Muhammad Irfan on 07/04/2024.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {

  @EnvironmentObject var router: Router

    var body: some View {
      VStack {
        VideoPlayer(videoURL: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4")!)
          .edgesIgnoringSafeArea(.all)
      }
      .navigationBarItems( leading: Button(action: { router.back() }) {
                Image(systemName: "arrow.left")
                    .foregroundColor(.white)
                    .padding(.leading, 0)
       })

    }
}

struct VideoPlayer: UIViewControllerRepresentable {
    var videoURL: URL

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let player = AVPlayer(url: videoURL)
        player.playImmediately(atRate: 1.0)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player

        return playerViewController
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        // Update the view controller if needed
    }
}


#Preview {
    VideoPlayerView()
}
