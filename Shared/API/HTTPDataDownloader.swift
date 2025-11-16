//
//  HTTPDataDownloader.swift
//  CryptoCoinsAPIApp
//
//  Created by Sachin Randive on 16/11/25.
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
