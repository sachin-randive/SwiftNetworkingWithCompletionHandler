//
//  CoinDetailsCache.swift
//  CryptoCoinsAPIApp
//
//  Created by Sachin Randive on 16/11/25.
//

import Foundation
class CoinDetailsCache {
    static let shared = CoinDetailsCache()
    private init() {}
    private var cache: [String: CoinDetails] = [:]
    
    func setCoinDetails(_ coinDetails: CoinDetails, for id: String) {
        cache[id] = coinDetails
    }
    
    func coinDetails(for id: String) -> CoinDetails? {
        return cache[id]
    }
}
