//
//  ContentViewModel.swift
//  AsyncAwaitApi
//
//  Created by Sachin Randive on 02/11/25.
//

import Foundation
class ContentViewModel: ObservableObject {
    @Published var coins = [Coin]()
    @Published var errorMessage: String = ""
    private let cryptoCoinsService = CryptoCoinsService()
    init() {
        Task { await getCoinsData() }
    }
    
    @MainActor
    func getCoinsData()  async {
        do {
            let coins = try await self.cryptoCoinsService.fetchCoins()
            self.coins = coins
        } catch {
            self.errorMessage = error.localizedDescription
            print("DEBUG: Failed to fetch coins: \(error.localizedDescription)")
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
