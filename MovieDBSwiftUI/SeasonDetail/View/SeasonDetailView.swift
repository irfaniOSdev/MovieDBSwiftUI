//
//  SeasonDetailView.swift
//  MovieDBSwiftUI
//
//  Created by Muhammad Irfan on 06/04/2024.
//

import SwiftUI

struct SeasonDetailView: View {

  @State var viewModel = SeasonDetailViewModel()
  @EnvironmentObject var router: Router

    var body: some View {
      Text("Hello, Season Detail!")
        .onAppear {
        viewModel.fetchSeasonInfo()
      }
    }
}

#Preview {
    SeasonDetailView()
}
