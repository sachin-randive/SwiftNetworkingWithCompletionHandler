//
//  CoinDetails.swift
//  CryptoCoinsAPIApp
//
//  Created by Sachin Randive on 15/11/25.
//

import Foundation

struct CoinDetails: Decodable {
    let id: String
    let symbol: String
    let name: String
    let description: Description
}
struct Description: Decodable {
    let text: String
    
    enum CodingKeys: String, CodingKey {
        case text = "en"
    }
}
