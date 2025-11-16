//
//  CryptoCoinsService.swift
//  CryptoCoinsAPIApp
//
//  Created by Sachin Randive on 15/11/25.
//

import Foundation

class CoinDataService: HTTPDataDownloader {
    //Mark - Async Await call -> All Coins
    func fetchAllCoins() async throws -> [Coin] {
        guard let endPointString = allCoinsURLString else {
            throw CoinError.invalidURL
        }
        return try await fetchData(as: [Coin].self, endPoint: endPointString)
    }
    
    //Mark - Async Await call -> Coin details
    func fetchCoinDetails(id: String) async throws -> CoinDetails? {
        guard let endPointString = coinDetailsURLString(id: id) else {
            throw CoinError.invalidURL
        }
        return try await fetchData(as: CoinDetails?.self, endPoint: endPointString)
    }
    
    // Base Url
    private var baseUrlComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.coingecko.com"
        components.path = "/api/v3/coins/"
        return components
    }
    // AllCoinsURLString
    private var allCoinsURLString: String? {
        var components = baseUrlComponents
        components.path += "markets"
        components.queryItems = [.init(name: "vs_currency", value: "usd"),
                                 .init(name: "order", value: "market_cap_desc"),
                                 .init(name: "per_page", value: "20"),
                                 .init(name: "page", value: "1"),
                                 .init(name: "price_change_percentage", value: "24h")]
        return components.string
    }
    
    //CoinDetailsURLString
    private func coinDetailsURLString(id: String) -> String? {
        var components = baseUrlComponents
        components.path += "\(id)"
        components.queryItems = [.init(name: "localization", value: "false")]
        return components.string
    }
}


// Mark - Completion Handler Logic Now skipped
/*extension CoinDataService {
 
 private let BASE_URL = "https://api.coingecko.com/api/v3/coins/"
 var urlString: String { return "\(BASE_URL)markets?vs_currency=usd&order=market_cap_desc&per_page=50&page=1&price_change_percentage=24h"
 }
 
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
