//
//  SeasonListCodable.swift
//  MovieDBSwiftUI
//
//  Created by Muhammad Irfan on 07/04/2024.
//

import Foundation

// MARK: - SeasonListCodable
struct SeasonListCodable: Codable, Equatable {
    let page: Int?
    var results: [Series]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Series: Codable, Equatable, Identifiable {
    let id: Int
    let overview: String?
    let posterPath, name: String?

  enum CodingKeys: String, CodingKey {
    case id
    case overview
    case posterPath = "poster_path"
    case name
  }

  func getImagePath()-> String {
    "\(imageBaseURL)\(posterPath ?? "")"
  }
}
