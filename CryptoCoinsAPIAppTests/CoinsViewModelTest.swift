//
//  CoinsViewModelTest.swift
//  CryptoCoinsAPIAppTests
//
//  Created by Sachin Randive on 17/11/25.
//

import XCTest
@testable import CryptoCoinsAPIApp

class CoinsViewModelTest: XCTestCase {
    func testInit() {
        let service = MockCoinService()
        let viewModel = ContentViewModel(service: service)
        
        XCTAssertNotNil(viewModel, "Failed to initialize viewModel")
    }
    
    func testSuccessfulCoinsFetch() async  {
        let service = MockCoinService()
        let viewModel = ContentViewModel(service: service)
        
        await viewModel.getCoinsData()
        XCTAssertTrue(viewModel.coins.count > 0)
        XCTAssertEqual(viewModel.coins.count, 5)
        XCTAssertEqual(viewModel.coins, viewModel.coins.sorted { $0.marketCapRank < $1.marketCapRank })
    }
    
    func testCoinsFetchwithInvalidJSON() async  {
        let service = MockCoinService()
        service.mocData = mockCoinsData_invalidJSON
        let viewModel = ContentViewModel(service: service)
        
        await viewModel.getCoinsData()
        XCTAssertTrue(viewModel.coins.isEmpty)
        XCTAssertNotNil(viewModel.errorMessage)
        
    }
    
    func testThrowInvalidDataError() async  {
        let service = MockCoinService()
        service.mockError = CoinError.invalidData
        let viewModel = ContentViewModel(service: service)
        
        await viewModel.getCoinsData()
        XCTAssertTrue(viewModel.coins.isEmpty)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.errorMessage, CoinError.invalidData.errorDescription)
    }
}
