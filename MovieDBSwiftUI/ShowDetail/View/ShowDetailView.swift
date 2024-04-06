//
//  ShowDetailView.swift
//  MovieDBSwiftUI
//
//  Created by Muhammad Irfan on 06/04/2024.
//

import SwiftUI

struct ShowDetailView: View {

  @State var viewModel = ShowDetailViewModel()

  @EnvironmentObject var router: Router

  var body: some View {

    VStack {
      Text("Hello, Show Detail!")
        .onTapGesture {
        router.navigate(to: .seasonDetail)
      }
    }
    .onAppear {
      viewModel.fetchShowInfo()
    }
  }
}

#Preview {
    ShowDetailView()
}
