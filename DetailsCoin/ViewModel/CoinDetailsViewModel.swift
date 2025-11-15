//
//  CoinDetailsViewModel.swift
//  CryptoCoinsAPIApp
//
//  Created by Sachin Randive on 15/11/25.
//

import Foundation

class CoinDetailsViewModel: ObservableObject {
    private let coinDataService = CoinDataService()
    private let coinId: String
    
    init(coinId: String) {
        self.coinId = coinId
        Task { await fetchCoinDetails()}
    }
    
    func fetchCoinDetails() async {
       do {
           let details = try await coinDataService.fetchCoinDetails(id: coinId)
           print("Debbug Coin Details:\(String(describing: details))")
        } catch {
            print("Error fetching coin details: \(error)")
       }
    }
}
