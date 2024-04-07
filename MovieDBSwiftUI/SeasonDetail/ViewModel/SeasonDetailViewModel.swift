//
//  SeasonDetailViewModel.swift
//  MovieDBSwiftUI
//
//  Created by Muhammad Irfan on 06/04/2024.
//

import Foundation
import Combine

class SeasonDetailViewModel: ObservableObject {

  private let service: MDServiceProtocol

  @Published var episodes: [Episode]?

  private var cancellables = Set<AnyCancellable>()

  init(service: MDServiceProtocol){
    self.service = service
    self.fetchSeasonInfo()
  }

  func fetchSeasonInfo() {

    let requestPublisher = service.requestData()
      .receive(on: DispatchQueue.main) // Receive on the main queue
      .eraseToAnyPublisher() as AnyPublisher<SeasonDetailCodable, Error>

    requestPublisher
      .sink(receiveCompletion: { completion in
        switch completion {
        case .finished:
          break
        case .failure(let error):
          print(error)
        }
      }, receiveValue: { model in
          self.episodes = model.episodes
      })
      .store(in: &cancellables)
  }
}
