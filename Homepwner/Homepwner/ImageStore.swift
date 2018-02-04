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
        // to get a URL and save the image
        // Create full URL for image
        let url = imageURL(forKey: key)
        // Turn image into JPEG data
        if let data = UIImageJPEGRepresentation(image, 0.5) {
            // Write it to full URL
            let _ = try? data.write(to: url, options: [.atomic])
        }
        
    }
    
    
    func image(forKey key: String) -> UIImage? {
        //return cache.object(forKey: key as NSString)
        
        if let existingImage = cache.object(forKey: key as NSString) {
            return existingImage
        }
        let url = imageURL(forKey: key)
        guard let imageFromDisk = UIImage(contentsOfFile: url.path) else {
            return nil }
        cache.setObject(imageFromDisk, forKey: key as NSString)
        return imageFromDisk
    }
    
    
    func deleteImage(forKey key: String) {
        cache.removeObject(forKey: key as NSString)
        
        // make sure that when an image is deleted from the store, it is also deleted from the filesystem
        let url = imageURL(forKey: key)
        //FileManager.default.removeItem(at: url)
        // update deleteImage(forKey:) to call removeItem(at:) using a do-catch statement
        do {
            try FileManager.default.removeItem(at: url)
        } catch let deleteError {
            //print("Error removing the image from disk: \(error)")
            print("Error removing the image from disk: \(deleteError)")
            
        }
        
    }
    
    // Implement a new method in ImageStore.swift named imageURL(forKey:) to create a URL in the documents directory using a given key.
    func imageURL(forKey key: String) -> URL {
        let documentsDirectories =
            FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent(key)
    }
    
}
