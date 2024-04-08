//
//  MockNetworkService.swift
//  MovieDBSwiftUITests
//
//  Created by Muhammad Irfan on 08/04/2024.
//

import Foundation
import Combine
import XCTest
@testable import MovieDBSwiftUI

class SeasonListViewModelTests: XCTestCase {

    var viewModel: SeasonListViewModel!
    var mockService: MockSeasonListService!

    override func setUp() {
        super.setUp()
      mockService = MockSeasonListService(page: 1, mockFilePath: "topRatedList")
      viewModel = SeasonListViewModel(service: mockService)

    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }

    func testFetchSeasonInfo_Success() {
      let expectation = XCTestExpectation(description: "Fetch season info successfully")
      let mockData:SeasonListCodable = loadMockData(fromFile: "topRatedList")

      viewModel.fetchSeasonInfo()

      var cancellable: AnyCancellable? = nil
      cancellable = viewModel.$model
           .drop(while: { $0 == nil })
           .sink { model in
               XCTAssertEqual(model, mockData)
               XCTAssertFalse(self.viewModel.showAlert)
               XCTAssertFalse(self.viewModel.isLoading)
               expectation.fulfill()
               cancellable?.cancel()
           }

        wait(for: [expectation], timeout: 5.0)
    }

    func loadMockData<T: Decodable>(fromFile fileName: String) -> T {
        guard let jsonURL = Bundle(for: SeasonListViewModelTests.self).url(forResource: fileName, withExtension: "json") else {
            fatalError("Mock data file not found")
        }

        do {
            let jsonData = try Data(contentsOf: jsonURL)
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(T.self, from: jsonData)
            return decodedData
        } catch {
            fatalError("Error loading mock data: \(error)")
        }
    }
}
