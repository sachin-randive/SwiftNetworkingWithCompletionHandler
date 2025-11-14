//
//  Coin.swift
//  AsyncAwaitApi
//
//  Created by Sachin Randive on 02/11/25.
//

import Foundation

struct Coin: Codable, Identifiable {
    let id, symbol, name: String
    let image: String
    let currentPrice: Double
    let marketCapRank: Int
    let priceChange24H, priceChangePercentage24H: Double
    
    var imageUrl: URL? {
        return URL(string: image)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCapRank = "market_cap_rank"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
    }
}

extension Coin {
    static var sample = Coin(
        id: "1",
        symbol: "BTC",
        name: "Bitcoin",
        image: "https://example.com/image.png",
        currentPrice: 10000.0,
        marketCapRank: 5,
        priceChange24H: 100.0,
        priceChangePercentage24H: 1.0
    )
}
