//
//  Router.swift
//  MovieDBSwiftUI
//
//  Created by Muhammad Irfan on 06/04/2024.
//

import Foundation
import SwiftUI

enum Destination {
    case showDetail
    case seasonDetail
    // Add more destinations as needed
}

class Router: ObservableObject {
  @Published var currentDestination: Destination = .showDetail

  func navigate(to destination: Destination) {
    self.currentDestination = destination
  }

  func back() {
    self.currentDestination = .showDetail
  }
}
