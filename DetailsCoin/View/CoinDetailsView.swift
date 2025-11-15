//
//  CoinDetailsView.swift
//  CryptoCoinsAPIApp
//
//  Created by Sachin Randive on 15/11/25.
//

import SwiftUI

struct CoinDetailsView: View {
    let coin: Coin
    @ObservedObject var viewModel: CoinDetailsViewModel
    init(coin: Coin) {
        self.coin = coin
        self.viewModel = CoinDetailsViewModel(coinId: "\(coin.id)")
    }
    var body: some View {
        Text("Coins deatils view: \(coin.name)")
    }
}

//#Preview {
//    CoinDetailsView()
//}
