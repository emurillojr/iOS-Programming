//
//  PhotoInfoViewController.swift
//  Photorama
//
//  Created by user135340 on 2/22/18.
//  Copyright © 2018 Murillo. All rights reserved.
//

//import Foundation

import UIKit
class PhotoInfoViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    
    // pass both the Photo and the PhotoStore to the PhotoInfoViewController
    var photo: Photo! {
        didSet {
            navigationItem.title = photo.title
        }
    }
    var store: PhotoStore!
    
    // override viewDidLoad() to set the image on the imageView when the view is loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        store.fetchImage(for: photo) { (result) -> Void in
            switch result {
            case let .success(image):
                self.imageView.image = image
            case let .failure(error):
                print("Error fetching image for photo: \(error)")
            }
        }
    }
    
    
    
    
}
