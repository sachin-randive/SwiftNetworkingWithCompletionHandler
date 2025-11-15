//
//  ContentViewModel.swift
//  AsyncAwaitApi
//
//  Created by Sachin Randive on 02/11/25.
//

import Foundation

class ContentViewModel: ObservableObject {
    @Published var coins = [Coin]()
    private let cryptoCoinsService = CryptoCoinsService()
    init() {
        getCoinsData()
    }
    func getCoinsData() {
        cryptoCoinsService.fetchCoins {[weak self] result in
            switch result {
            case .success(let coins):
                self?.coins = coins
            case .failure(let error):
                print("DEBUG: Failed to fetch coins: \(error)")
            }
        }
    }
}

// MARK - URLSession

/*extension ContentViewModel {
    func fetchCoinsWithURLSession() {
        guard let url = URL(string: urlString) else {
            print( "DEBUG: Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if let error = error {
                    print("DEBUG: Failed to fetch data with error: \(error)")
                    return
                }
                
                guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                    print("DEBUG: No HTTPURLResponse returned from the server.")
                    return
                }
                
                guard let data = data else {
                    print("DEBUG: No data returned from the server.")
                    return
                }
                
                guard let coinsData = try? JSONDecoder().decode([Coin].self, from: data) else {
                    print("DEBUG: Failed to decode JSON data.")
                    return
                }
                
                self.coins = coinsData
            }
        } .resume()
        
    }
}
*/
