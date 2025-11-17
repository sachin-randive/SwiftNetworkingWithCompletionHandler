//
//  MockCoinService.swift
//  CryptoCoinsAPIApp
//
//  Created by Sachin Randive on 17/11/25.
//

import Foundation

class MockCoinService: CoinServiceProtocol {
    
    var mocData: Data?
    var mockError: CoinError?
    func fetchAllCoins() async throws -> [Coin] {
        //        let bitcoin: Coin = .init(id: "bitcoin", symbol: "BTC", name: "Bitcoin", image: "bitcoin", currentPrice: 28000.0, marketCapRank: 1, priceChange24H: 100.0, priceChangePercentage24H: 0.0333)
        //        return [bitcoin]
        if let mockError = mockError {
            throw mockError
        }
        do {
            let coins = try JSONDecoder().decode([Coin].self, from: mocData ?? mockCoinsData_markrtCapDesc)
            return coins
        } catch {
            throw error as? CoinError ?? .unkown(error)
        }
    }
    
    func fetchCoinDetails(id: String) async throws -> CoinDetails? {
        let description = Description(text: "Bitcoin is the first and most well-known cryptocurrency, launched in 2009 by an anonymous individual or group known as Satoshi Nakamoto.")
        let bitcoin: CoinDetails = .init(id: "bitcoin", symbol: "BTC", name: "Bitcoin", description: description)
        return bitcoin
    }
}
