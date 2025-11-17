//
//  ImageCache.swift
//  CryptoCoinsAPIAppTests
//
//  Created by Sachin Randive on 17/11/25.
//

import UIKit

class ImageCache {
    static let shared = ImageCache()
    private init() {}
    private let cache = NSCache<NSString, UIImage>()
    func set(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
    
    func get(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
}
