//
//  EpisodeDetailViewModel.swift
//  MovieDBSwiftUI
//
//  Created by Muhammad Irfan on 07/04/2024.
//

import Foundation
import Combine

class EpisodeDetailViewModel: ObservableObject {

  private let episode: Episode

  init(episode: Episode) {
    self.episode = episode
  }

  func getImagePath()-> String {
    "\(imageBaseURL)\(episode.stillPath ?? "")"
  }

  func getOverView()-> String {
    return episode.overview ?? ""
  }
}
