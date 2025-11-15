//
//  CryptoCoinsService.swift
//  CryptoCoinsAPIApp
//
//  Created by Sachin Randive on 15/11/25.
//

import Foundation

class CoinDataService {
    
    private let BASE_URL = "https://api.coingecko.com/api/v3/coins/"
    
    var urlString: String { return "\(BASE_URL)markets?vs_currency=usd&order=market_cap_desc&per_page=50&page=1&price_change_percentage=24h"
    }
    private var detailsUrlCoin: String { return "\(BASE_URL)bitcoin?localization=false" }
    
    // Async Await call
    
    func fetchCoins() async throws -> [Coin] {
        guard let url = URL(string: urlString) else {
            return []
        }
        
        let (data, responce) = try await URLSession.shared.data(from: url)
        
        guard let httpResponce = responce as? HTTPURLResponse, httpResponce.statusCode == 200 else {
            throw  CoinError.serverError
        }
        do {
            return try JSONDecoder().decode([Coin].self, from: data)
        } catch {
            return []
        }
    }
    
    // Coin details Call
    func fetchCoinDetails(id: String) async throws -> CoinDetails? {
        guard let url = URL(string: detailsUrlCoin) else {
            return nil
        }
        
        let (data, responce) = try await URLSession.shared.data(from: url)
        
        guard let httpResponce = responce as? HTTPURLResponse, httpResponce.statusCode == 200 else {
            throw  CoinError.serverError
        }
        do {
            let coinDetails = try JSONDecoder().decode(CoinDetails.self, from: data)
            return coinDetails
        } catch {
            return nil
        }
    }
}


// Mark - Completion Handler
extension CoinDataService {
    
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
