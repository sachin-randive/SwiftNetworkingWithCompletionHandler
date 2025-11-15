//
//  CryptoCoinsService.swift
//  CryptoCoinsAPIApp
//
//  Created by Sachin Randive on 15/11/25.
//

import Foundation

class CryptoCoinsService {
    
    private let BASE_URL = "https://api.coingecko.com/api/v3/coins/"
    
    var urlString: String { return "\(BASE_URL)markets?vs_currency=usd&order=market_cap_desc&per_page=50&page=1&price_change_percentage=24h"
    }
    
    // Async Await call
    
    func fetchCoins() async throws -> [Coin] {
        let (data, _) = try await URLSession.shared.data(from: URL(string: urlString)!)
        return try JSONDecoder().decode([Coin].self, from: data)
    }
}


// Mark - Completion Handler
extension CryptoCoinsService {
    
    func fetchCoinsWithCompletionHandler(complition: @escaping (Result<[Coin], CoinError>) -> Void) {
        guard let url = URL(string: urlString) else {
            print( "DEBUG: Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("DEBUG: Failed to fetch data with error: \(error)")
                    complition(.failure(.invalidURL))
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
                do {
                    let coinData = try JSONDecoder().decode([Coin].self, from: data)
                    complition(.success(coinData))
                    
                } catch {
                    complition(.failure(.invalidData))
                }
            }
        } .resume()
        
    }
}
