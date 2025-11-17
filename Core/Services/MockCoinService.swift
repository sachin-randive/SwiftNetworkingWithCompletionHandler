//
//  MockCoinService.swift
//  CryptoCoinsAPIApp
//
//  Created by Sachin Randive on 17/11/25.
//

import Foundation

class MockCoinService: CoinServiceProtocol {
    func fetchAllCoins() async throws -> [Coin] {
        let bitcoin: Coin = .init(id: "bitcoin", symbol: "BTC", name: "Bitcoin", image: "bitcoin", currentPrice: 28000.0, marketCapRank: 1, priceChange24H: 100.0, priceChangePercentage24H: 0.0333)
        return [bitcoin]
    }
    
    func fetchCoinDetails(id: String) async throws -> CoinDetails? {
        let description = Description(text: "Bitcoin is the first and most well-known cryptocurrency, launched in 2009 by an anonymous individual or group known as Satoshi Nakamoto.")
        let bitcoin: CoinDetails = .init(id: "bitcoin", symbol: "BTC", name: "Bitcoin", description: description)
        return bitcoin
    }
}
