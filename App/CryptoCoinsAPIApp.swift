//
//  AsyncAwaitApiApp.swift
//  AsyncAwaitApi
//
//  Created by Sachin Randive on 02/11/25.
//

import SwiftUI

//https://www.coingecko.com/

@main
struct CryptoCoinsAPIApp: App {
    @StateObject private var viewModel = ContentViewModel(service: CoinDataService())
    
    var body: some Scene {
        WindowGroup {
           // ContentView(service: CoinDataService())
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
