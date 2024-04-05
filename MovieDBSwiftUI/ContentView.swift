//
//  ContentView.swift
//  MovieDBSwiftUI
//
//  Created by Muhammad Irfan on 04/04/2024.
//

import SwiftUI
import MDNetworkManager

struct ContentView: View {
  let networkManager = MDNetworkManager()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
