//
//  RequestShowService.swift
//  MovieDBSwiftUI
//
//  Created by Muhammad Irfan on 06/04/2024.
//

import Foundation
import Combine

class ShowDetailViewModel: ObservableObject {

  @Published var model: ShowDetailCodable?
  @Published var selectedTab = 0
  @Published var showAlert = false
  @Published var error: Error?

  private let service: MDServiceProtocol

  private var cancellables = Set<AnyCancellable>()

  init(service: MDServiceProtocol) {
    self.service = service
  }

  func getName() -> String {
    model?.name ?? ""
  }

  func getOverView() -> String {
    model?.overview ?? model?.originalName ?? ""
  }

  func fetchShowInfo() {

    let requestPublisher = service.requestData()
      .receive(on: DispatchQueue.main) // Receive on the main queue
      .eraseToAnyPublisher() as AnyPublisher<ShowDetailCodable, Error>

    requestPublisher
      .sink(receiveCompletion: { completion in
        switch completion {
        case .finished:
          break
        case .failure(let error):
          print(error)
          self.showAlert = true
          self.error = error
        }
      }, receiveValue: { model in
          self.model = model
      })
      .store(in: &cancellables)
  }
}
