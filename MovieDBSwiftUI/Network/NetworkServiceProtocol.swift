//
//  NetworkServiceProtocol.swift
//  MovieDBSwiftUI
//
//  Created by Muhammad Irfan on 06/04/2024.
//

import Foundation
import MDNetworkManager
import Combine

protocol MDServiceProtocol {
  var networkManager: NetworkServiceProtocol { get }
  var endPoint: URL { get }
  var headers: [String: String] { get }
  var httpMethod : HTTPMethod { get }
  func requestData<T: Decodable>() -> AnyPublisher<T, Error>
}

extension MDServiceProtocol {

  var headers: [String: String] {
    return ["Authorization": "Bearer \(authToken)", "Accept": "application/json"]
  }

  var networkManager: NetworkServiceProtocol {
    return MDNetworkManager()
  }

  var httpMethod: HTTPMethod {
    return .GET
  }

  func requestData<T: Decodable>() -> AnyPublisher<T, Error> {
    return networkManager.fetchData(from: endPoint, method: httpMethod, headers: headers, parameters: nil)
  }
}
