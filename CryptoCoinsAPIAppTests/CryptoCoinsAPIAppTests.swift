//
//  CryptoCoinsAPIAppTests.swift
//  CryptoCoinsAPIAppTests
//
//  Created by Sachin Randive on 17/11/25.
//

import XCTest
@testable import CryptoCoinsAPIApp

final class CryptoCoinsAPIAppTests: XCTestCase {
    
    func testDecodeCoinsIntoArray_marketCapDesc() throws {
        do {
            let coins = try JSONDecoder().decode([Coin].self, from: mockCoinsData_markrtCapDesc)
            XCTAssertTrue(coins.count > 0)
            XCTAssertEqual(coins.count, 5)
            XCTAssertEqual(coins, coins.sorted { $0.marketCapRank < $1.marketCapRank })
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
}
