//
//  ContentView.swift
//  AsyncAwaitApi
//
//  Created by Sachin Randive on 02/11/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: ContentViewModel
    private let service: CoinServiceProtocol
    init(service: CoinServiceProtocol) {
        self.service = service
        self._viewModel = StateObject(wrappedValue: ContentViewModel(service: service))
    }
    
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.coins) { coin in
                    NavigationLink(value: coin) {
                        CoinRowView(coin: coin)
                    }
                }
            }
            .navigationTitle(Text("Live Prices"))
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: Coin.self) { coin in
                CoinDetailsView(coin: coin, service: service)
            }
        }
    }
}

#Preview {
    ContentView(service: CoinDataService())
}
