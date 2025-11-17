//
//  CoinImageView.swift
//  CryptoCoinsAPIAppTests
//
//  Created by Sachin Randive on 17/11/25.
//

import SwiftUI

struct CoinImageView: View {
    @ObservedObject var imageLoader: ImageLoader
    init(url: String) {
        self.imageLoader = ImageLoader(urlString: url)
    }
    var body: some View {
       if let image = imageLoader.image {
            image
               .resizable()
               .scaledToFit()
        }
    }
}

#Preview {
    CoinImageView(url: "https://coin-images.coingecko.com/coins/images/36440/large/MEW.png?1711442286")
}
