//
//  CoinDetailsViewModel.swift
//  CryptoCoinsAPIApp
//
//  Created by Sachin Randive on 15/11/25.
//

import Foundation

class CoinDetailsViewModel: ObservableObject {
    private let service: CoinServiceProtocol
    private let coinId: String
    @Published var coinDetails: CoinDetails?
    
    init(coinId: String, service: CoinServiceProtocol) {
        self.service = service
        self.coinId = coinId
        //Task { await fetchCoinDetails()}
    }
    
    @MainActor
    func fetchCoinDetails() async {
       // try? await Task.sleep(nanoseconds: 2_000_000_000)
       do {
           let details = try await service.fetchCoinDetails(id: coinId)
         //  print("Debbug Coin Details:\(String(describing: details))")
           self.coinDetails = details
        } catch {
            print("Error fetching coin details: \(error)")
       }
    }
}
