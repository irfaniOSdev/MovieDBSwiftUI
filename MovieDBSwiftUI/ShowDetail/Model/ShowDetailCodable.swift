//
//  ShowDetailCodable.swift
//  MovieDBSwiftUI
//
//  Created by Muhammad Irfan on 06/04/2024.
//

import Foundation

// MARK: - ShowDetailCodable
struct ShowDetailCodable: Codable {
    let backdropPath: String?
    let id: Int
    let name: String?
    let numberOfEpisodes, numberOfSeasons: Int?
    let originalName, overview: String?
    let posterPath: String?
    let seasons: [Season]?

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id
        case name
        case numberOfEpisodes = "number_of_episodes"
        case numberOfSeasons = "number_of_seasons"
        case originalName = "original_name"
        case overview
        case posterPath = "poster_path"
        case seasons
    }
}


// MARK: - Season
struct Season: Codable {
    let episodeCount: Int
    let id: Int
    let name, overview: String?
    let posterPath: String?
    let seasonNumber: Int?

    enum CodingKeys: String, CodingKey {
        case episodeCount = "episode_count"
        case id, name, overview
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
    }
}
