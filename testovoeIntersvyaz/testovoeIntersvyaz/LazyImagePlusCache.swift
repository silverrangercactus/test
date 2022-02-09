//
//  LazyImageView.swift
//  testovoeIntersvyaz
//
//  Created by Fedor Boriskin on 09.02.2022.
//

import Foundation
import UIKit

class LazyLoadView: UIImageView {
   
    private let imageCache: NSCache<AnyObject, UIImage> = {
        let imageCache = NSCache<AnyObject, UIImage>()
        imageCache.countLimit = 1000
        imageCache.totalCostLimit = 200
        return imageCache
    }()
    

    func loadImage(imageURL: URL) {
        
        if let cachedImage = self.imageCache.object(forKey: imageURL as AnyObject) {
            self.image = cachedImage
            debugPrint("Cache \(imageURL )")
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            
            if let imageData = try? Data(contentsOf: imageURL) {
                debugPrint("Network \(imageURL )")
                if let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self?.imageCache.setObject(image, forKey: imageURL as AnyObject)
                        self?.image = image
                    }
                }
            }
        }
    }
}
