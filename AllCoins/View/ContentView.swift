//
//  ContentView.swift
//  AsyncAwaitApi
//
//  Created by Sachin Randive on 02/11/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: ContentViewModel = .init()
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.coins) { coin in
                   CoinRowView(coin: coin)
                }
                if viewModel.coins.isEmpty {
                    Text("Debugg: No data available :\(viewModel.errorMessage)")
                }
            }
            .navigationTitle(Text("Live Prices"))
            //.navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
