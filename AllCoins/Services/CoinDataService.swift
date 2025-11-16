//
//  CryptoCoinsService.swift
//  CryptoCoinsAPIApp
//
//  Created by Sachin Randive on 15/11/25.
//

import Foundation

protocol HTTPDataDownloader {
    func fetchData<T: Decodable>(as type: T.Type, endPoint: String) async throws -> T
}

extension HTTPDataDownloader {
    
    func fetchData<T: Decodable>(as type: T.Type, endPoint: String) async throws -> T {
        guard let url = URL(string: endPoint) else {
            throw CoinError.invalidURL
        }
        
        let (data, responce) = try await URLSession.shared.data(from: url)
        
        guard let httpResponce = responce as? HTTPURLResponse, httpResponce.statusCode == 200 else {
            throw  CoinError.serverError
        }
        do {
            let coinDetails = try JSONDecoder().decode(T.self, from: data)
            return coinDetails
        } catch {
            throw error as? CoinError ?? .unkown(error)
        }
        
    }
}
class CoinDataService: HTTPDataDownloader {
    
    private let BASE_URL = "https://api.coingecko.com/api/v3/coins/"
    // Async Await call
    func fetchCoins() async throws -> [Coin] {
        var urlString: String { return "\(BASE_URL)markets?vs_currency=usd&order=market_cap_desc&per_page=50&page=1&price_change_percentage=24h"
        }
        return try await fetchData(as: [Coin].self, endPoint: urlString)
    }
    
    // Coin details Call
    func fetchCoinDetails(id: String) async throws -> CoinDetails? {
        var detailsUrlCoin: String { return "\(BASE_URL)\(id)?localization=false" }
        return try await fetchData(as: CoinDetails?.self, endPoint: detailsUrlCoin)
    }
}


// Mark - Completion Handler Logic Now skipped
/*extension CoinDataService {
    
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
*/
