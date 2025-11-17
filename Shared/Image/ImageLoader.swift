//
//  ImageLoader.swift
//  CryptoCoinsAPIAppTests
//
//  Created by Sachin Randive on 17/11/25.
//

import SwiftUI

class ImageLoader: ObservableObject {
    @Published var image: Image?
    
    private let urlString: String
    
    init(urlString: String) {
        self.urlString = urlString
        Task {
            await self.loadImage()
        }
    }
    @MainActor
    private func loadImage() async {
        if let cachedImage = ImageCache.shared.get(forKey: urlString) {
            print("Debug: Image loaded from cache:")
            self.image = Image(uiImage: cachedImage)
            return
        }
        guard let url = URL(string: urlString) else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let uitImage = UIImage(data: data) else { return }
            ImageCache.shared.set(uitImage, forKey: urlString)
            self.image = Image(uiImage: uitImage)
            
        }catch {
            print("Debug: Failed to fetch image from URL: \(urlString)")
        }
    }
}

