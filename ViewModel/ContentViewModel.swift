//
//  ContentViewModel.swift
//  AsyncAwaitApi
//
//  Created by Sachin Randive on 02/11/25.
//

import Foundation
@MainActor
class ContentViewModel: ObservableObject {
    @Published var coins = [Coin]()
    private let cryptoCoinsService = CryptoCoinsService()
    init() {
        getCoinsData()
    }
    func getCoinsData() {
        Task {
            do {
                let coins = try await self.cryptoCoinsService.fetchCoins()
                self.coins = coins
            } catch {
                print("DEBUG: Failed to fetch coins: \(error)")
            }
        }
    }
    
}

// Mark - Completion Handler Clouser call

extension ContentViewModel {
    func getCoinsDataWithCompletionHandler() {
        cryptoCoinsService.fetchCoinsWithCompletionHandler {[weak self] result in
            switch result {
            case .success(let coins):
                self?.coins = coins
            case .failure(let error):
                print("DEBUG: Failed to fetch coins: \(error)")
            }
        }
    }
}
