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
    
    @Published var coinDetails: CoinDetails?
    
    init(service: CoinServiceProtocol) {
        self.service = service
        //Task { await getCoinsData() }
    }
    
    @MainActor
    func getCoinsData()  async {
        do {
            let coins = try await self.service.fetchAllCoins()
            self.coins.append(contentsOf: coins)
        } catch {
            self.errorMessage = error.localizedDescription
            print("DEBUG: Failed to fetch coins: \(error.localizedDescription)")
        }
    }
    
    // enviornment Object
  
    
    @MainActor
    func fetchCoinDetails(coinId: String) async {
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
