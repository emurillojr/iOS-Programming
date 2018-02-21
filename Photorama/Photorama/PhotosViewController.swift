//
//  PhotosViewController.swift
//  Photorama
//
//  Created by user135340 on 2/21/18.
//  Copyright © 2018 Murillo. All rights reserved.
//

//import Foundation
import UIKit
// define the PhotosViewController class and give it an imageView property.
class PhotosViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var store: PhotoStore! // add a property to hang on to an instance of PhotoStore
    
    // override viewDidLoad() and fetch the interesting photos.
    override func viewDidLoad() {
        super.viewDidLoad()
        //store.fetchInterestingPhotos()
        store.fetchInterestingPhotos { (photosResult) -> Void in
            switch photosResult {
            case let .success(photos):
                print("Successfully found \(photos.count) photos.")
                
                if let firstPhoto = photos.first {
                    self.updateImageView(for: firstPhoto)
                }
                
            case let .failure(error):
                print("Error fetching interesting photos: \(error)")
            }
        }
    }

    // method that will fetch the image and display it on the image view
    func updateImageView(for photo: Photo) {
        store.fetchImage(for: photo) {
            (imageResult) -> Void in
            switch imageResult {
            case let .success(image):
                self.imageView.image = image
            case let .failure(error):
                print("Error downloading image: \(error)")
            }
        }
    }




}
    
    
    
    
    
    
    

