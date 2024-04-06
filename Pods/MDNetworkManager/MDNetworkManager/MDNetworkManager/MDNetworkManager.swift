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

public protocol NetworkServiceProtocol {
  func fetchData<T: Decodable>(from url: URL, method: HTTPMethod, headers: [String: String]?, parameters: [String: Any]?) -> AnyPublisher<T, Error>
}

public class MDNetworkManager: NetworkServiceProtocol {
    private let session: URLSession

    public init(session: URLSession = .shared) {
        self.session = session
    }

    public func fetchData<T: Decodable>(from url: URL, method: HTTPMethod = .GET, headers: [String: String]? = nil, parameters: [String: Any]? = nil) -> AnyPublisher<T, Error> {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }

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
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error -> Error in
                if let urlError = error as? URLError, urlError.code == .notConnectedToInternet {
                    return NetworkError.noInternetConnection
                }
                return error
            }
            .eraseToAnyPublisher()
    }
}

public enum NetworkError: Error {
    case noInternetConnection
}
