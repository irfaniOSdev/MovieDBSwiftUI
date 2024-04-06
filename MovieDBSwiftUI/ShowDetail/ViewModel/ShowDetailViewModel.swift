//
//  RequestShowService.swift
//  MovieDBSwiftUI
//
//  Created by Muhammad Irfan on 06/04/2024.
//

import Foundation
import Combine

class ShowDetailViewModel: ObservableObject {

  let service: MDServiceProtocol

  private var cancellables = Set<AnyCancellable>()

  init(service: MDServiceProtocol = ShowDetailService(seriesId: 65701)) {
    self.service = service
  }

  func fetchShowInfo() {

    let requestPublisher = service.requestData() as AnyPublisher<ShowDetailCodable, Error>

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
