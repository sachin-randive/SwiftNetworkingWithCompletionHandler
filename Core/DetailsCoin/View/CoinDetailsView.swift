//
//  CoinDetailsView.swift
//  CryptoCoinsAPIApp
//
//  Created by Sachin Randive on 15/11/25.
//

import SwiftUI

struct CoinDetailsView: View {
    @EnvironmentObject var viewModel: ContentViewModel
    let coin: Coin
//    @ObservedObject var viewModel: CoinDetailsViewModel
   // init(coin: Coin, service: CoinServiceProtocol) {
    init(coin: Coin) {
        self.coin = coin
       // self.viewModel = CoinDetailsViewModel(coinId:coin.id, service: service)
    }
    var body: some View {
            VStack(alignment: .leading) {
               if let details = viewModel.coinDetails {
                   HStack {
                       VStack(alignment: .leading) {
                           Text("\(details.name)")
                               .font(.subheadline)
                               .fontWeight(.semibold)
                           Text("\(details.symbol)")
                               .font(.footnote)
                       }
                       Spacer()
                       CoinImageView(url: coin.image)
                           .frame(width: 64, height: 64)
                   }
                   Text("\(details.description.text)")
                       .padding(.vertical)
                }
            }
            .task {
              // await viewModel.fetchCoinDetails()
                await viewModel.fetchCoinDetails(coinId: coin.id)
            }
            .padding()
            Spacer()
    }
}

//#Preview {
//    CoinDetailsView()
//}
