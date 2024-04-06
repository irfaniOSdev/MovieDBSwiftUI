//
//  SeasonDetailViewModel.swift
//  MovieDBSwiftUI
//
//  Created by Muhammad Irfan on 06/04/2024.
//

import Foundation
import Combine

class SeasonDetailViewModel: ObservableObject {

  let service: MDServiceProtocol

  private var cancellables = Set<AnyCancellable>()

  init(service: MDServiceProtocol = SeasonDetailService(seriesId: 65701, seasonNumber: 0)){
    self.service = service
  }

  func fetchSeasonInfo() {

    let requestPublisher = service.requestData() as AnyPublisher<SeasonDetailCodable, Error>

    requestPublisher
      .sink(receiveCompletion: { completion in
        switch completion {
        case .finished:
          break
        case .failure(let error):
          print(error)
        }
      }, receiveValue: { model in
          print(model)
      })
      .store(in: &cancellables)
  }
}
