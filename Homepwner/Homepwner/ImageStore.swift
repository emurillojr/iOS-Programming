//
//  ImageStore.swift
//  Homepwner
//
//  Created by user135340 on 2/4/18.
//  Copyright © 2018 Murillo. All rights reserved.
//

import UIKit

// add a property that is an instance of NSCache
class ImageStore {
    let cache = NSCache<NSString,UIImage>()
    
    // implement three methods for adding, retrieving, and deleting an image from the dictionary
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
    func image(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    func deleteImage(forKey key: String) {
        cache.removeObject(forKey: key as NSString)
    }
    
    
}
