//
//  MockListSerivce.swift
//  MovieDBSwiftUITests
//
//  Created by Muhammad Irfan on 09/04/2024.
//

import XCTest
import MovieDBSwiftUI
import Combine

@testable import MovieDBSwiftUI

final class MockSeasonListService: MDServiceProtocol {
    var page: Int
    var mockFilePath: String

  init(page: Int, mockFilePath: String) {
    self.page = page
    self.mockFilePath = mockFilePath
  }

  var endPoint: URL {
    guard let jsonURL = getFileURL() else {
      fatalError("Mock data file not found")
    }
    return jsonURL
  }

  func requestData<T: Decodable>() -> AnyPublisher<T, Error> {

    guard let jsonURL = getFileURL() else {
      let error = NSError(domain: "MockErrorDomain", code: 404, userInfo: [NSLocalizedDescriptionKey: "Mock data file not found"])
      return Fail(error: error).eraseToAnyPublisher()
    }

    do {
      let jsonData = try Data(contentsOf: jsonURL)
      let decoder = JSONDecoder()
      let decodedData = try decoder.decode(T.self, from: jsonData)

      return Just(decodedData)
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    } catch {
      return Fail(error: error)
        .eraseToAnyPublisher()
    }
  }

  func getFileURL()-> URL? {
    return  Bundle(for: SeasonListViewModelTests.self).url(forResource: mockFilePath, withExtension: "json")
  }
}
