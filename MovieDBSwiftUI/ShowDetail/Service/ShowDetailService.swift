//
//  ShowDetailService.swift
//  MovieDBSwiftUI
//
//  Created by Muhammad Irfan on 06/04/2024.
//

import Foundation

struct ShowDetailService: MDServiceProtocol {

  let seriesId: Int
  
  init(seriesId: Int) {
    self.seriesId = seriesId
  }

  var endPoint: URL {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "api.themoviedb.org"
    components.path = "/3/tv/\(seriesId)"
    components.queryItems = [
        URLQueryItem(name: "language", value: "en-US")]

    guard let url = components.url else {
      preconditionFailure("Invalid URL components: \(components)")
    }
    return url
  }
}
