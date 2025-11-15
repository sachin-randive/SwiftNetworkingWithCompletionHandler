//
//  ContentView.swift
//  AsyncAwaitApi
//
//  Created by Sachin Randive on 02/11/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel() //: ContentViewModel = .init()
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
                    CoinDetailsView()
            }
//            .overlay(content: {
//                if let errorMessage = viewModel.errorMessage {
//                    Text("Error: \(errorMessage)")
//                }
//            })
        }
    }
}

#Preview {
    ContentView()
}
