//
//  SeasonListService.swift
//  MovieDBSwiftUI
//
//  Created by Muhammad Irfan on 07/04/2024.
//

import Foundation

struct SeasonListService: MDServiceProtocol {

  var page: Int

  init(page: Int) {
    self.page = page
  }

  var endPoint: URL {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "api.themoviedb.org"
    components.path = "/3/tv/top_rated"
    components.queryItems = [
        URLQueryItem(name: "language", value: "en-US"),URLQueryItem(name: "page", value: "\(page)") ]

    guard let url = components.url else {
      preconditionFailure("Invalid URL components: \(components)")
    }
    return url
  }
}
