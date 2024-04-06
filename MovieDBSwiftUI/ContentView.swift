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
        if router.currentDestination == .showDetail {
          ShowDetailView()
        } else if router.currentDestination == .seasonDetail {
          SeasonDetailView()
        }
      }
      .navigationTitle("App")
      .environmentObject(router)
    }
  }
}

#Preview {
    ContentView()
}
