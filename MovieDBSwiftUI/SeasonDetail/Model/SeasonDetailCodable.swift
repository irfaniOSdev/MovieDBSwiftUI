//
//  SeasonDetailCodable.swift
//  MovieDBSwiftUI
//
//  Created by Muhammad Irfan on 06/04/2024.
//


import Foundation

// MARK: - SeasonDetailCodable
struct SeasonDetailCodable: Codable {
    let id: String?
    let episodes: [Episode]?
    let name, overview: String?
    let posterPath: String?
    let seasonNumber: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case episodes, name, overview
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
    }
}

// MARK: - Episode
struct Episode: Codable, Equatable {

  static func == (lhs: Episode, rhs: Episode) -> Bool {
    lhs.name == rhs.name

  }

  let episodeNumber: Int?
  let id: Int
  let name, overview: String?
  let seasonNumber: Int?
  let stillPath: String?

  enum CodingKeys: String, CodingKey {
    case episodeNumber = "episode_number"
    case id, name, overview
    case seasonNumber = "season_number"
    case stillPath = "still_path"
  }

  func getImagePath()-> String {
    "\(imageBaseURL)\(stillPath ?? "")"
  }
}

