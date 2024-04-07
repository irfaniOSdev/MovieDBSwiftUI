//
//  Router.swift
//  MovieDBSwiftUI
//
//  Created by Muhammad Irfan on 06/04/2024.
//

import Foundation
import SwiftUI

enum Destination {
    case seasonList
    case showDetail(viewModel: ShowDetailViewModel)
    case episodeDetail(viewModel: EpisodeDetailViewModel)
    case videoPlayer
}

class Router: ObservableObject {
  @Published var currentDestination: Destination = .seasonList
  private var navigationStack: [Destination] = []

  func navigate(to destination: Destination) {
    navigationStack.append(currentDestination)
    self.currentDestination = destination
  }

  func back() {
    guard let previousDestination = navigationStack.popLast() else {
      return
    }
    currentDestination = previousDestination
  }
}
