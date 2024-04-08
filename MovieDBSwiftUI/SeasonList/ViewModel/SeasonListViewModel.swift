//
//  SeasonListViewModel.swift
//  MovieDBSwiftUI
//
//  Created by Muhammad Irfan on 07/04/2024.
//

import Foundation
import Combine

class SeasonListViewModel: ObservableObject {

  @Published var model: SeasonListCodable?
  @Published var showAlert = false
  @Published var error: Error?

  private var currentPage = 1

  @Published var isLoading = false

  private var service: MDServiceProtocol

  private var cancellables = Set<AnyCancellable>()

  init(service: MDServiceProtocol = SeasonListService(page: 1)) {
    self.service = service
  }

  func fetchSeasonInfo() {

    guard !isLoading else { return }

    isLoading = true

    if var seasonListService = service as? SeasonListService {
      seasonListService.page = currentPage
      service = seasonListService
    }
    let requestPublisher = service.requestData()
      .receive(on: DispatchQueue.main) // Receive on the main queue
      .eraseToAnyPublisher() as AnyPublisher<SeasonListCodable, Error>

    requestPublisher
      .sink(receiveCompletion: { [weak self] completion in
        guard let self else { return }
        switch completion {
        case .finished:
          self.currentPage += 1
        case .failure(let error):
          print(error)
          self.showAlert = true
          self.error = error
        }
        self.isLoading = false
      }, receiveValue: { [weak self] model in
        guard let self else { return }
        self.isLoading = false
        if self.model == nil {
          self.model = model
        } else {
          self.model?.results?.append(contentsOf: model.results ?? [])
        }
      })
      .store(in: &cancellables)
  }
}
