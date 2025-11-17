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
    private let service: CoinServiceProtocol
    init(service: CoinServiceProtocol) {
        self.service = service
        Task { await getCoinsData() }
    }
    
    @MainActor
    func getCoinsData()  async {
        do {
            let coins = try await self.service.fetchAllCoins()
            self.coins = coins
        } catch {
            self.errorMessage = error.localizedDescription
            print("DEBUG: Failed to fetch coins: \(error.localizedDescription)")
        }
    }
}

// Mark - Completion Handler Clouser call Now Skipped
/*
extension ContentViewModel {
    func getCoinsDataWithCompletionHandler() {
        coinDataService.fetchCoinsWithCompletionHandler {[weak self] result in
            switch result {
            case .success(let coins):
                self?.coins = coins
            case .failure(let error):
                print("DEBUG: Failed to fetch coins: \(error)")
            }
        }
    }
}
*/
