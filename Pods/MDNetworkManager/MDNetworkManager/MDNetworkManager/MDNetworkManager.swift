//
//  MDNetworkManager.swift
//  MDNetworkManager
//
//  Created by Muhammad Irfan on 04/04/2024.
//

import Foundation
import Combine

public enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
    // Add other HTTP methods as needed
}

protocol NetworkServiceProtocol {
  func fetchData<T: Decodable>(from url: URL, method: HTTPMethod, parameters: [String: Any]?) -> AnyPublisher<T, Error>
}

public class MDNetworkManager: NetworkServiceProtocol {
    private let session: URLSession

  public init(session: URLSession = .shared) {
        self.session = session
    }

  public  func fetchData<T: Decodable>(from url: URL, method: HTTPMethod = .GET, parameters: [String: Any]? = nil) -> AnyPublisher<T, Error> {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        if let parameters = parameters {
            if method == .GET {
                var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
                components.queryItems = parameters.map { URLQueryItem(name: $0, value: "\($1)") }
                request.url = components.url
            } else {
                request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        }

        return session.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
