//
//  SeasonDetailService.swift
//  MovieDBSwiftUI
//
//  Created by Muhammad Irfan on 06/04/2024.
//

import Foundation

struct SeasonDetailService: MDServiceProtocol {

  let seriesId: Int
  let seasonNumber: Int

  init(seriesId: Int, seasonNumber: Int) {
    self.seriesId = seriesId
    self.seasonNumber = seasonNumber
  }

  var endPoint: URL {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "api.themoviedb.org"
    components.path = "/3/tv/\(seriesId)/season/\(seasonNumber)"
    components.queryItems = [
        URLQueryItem(name: "language", value: "en-US")]

     guard let url = components.url else {
          preconditionFailure("Invalid URL components: \(components)")
      }

      return url
  }
}
