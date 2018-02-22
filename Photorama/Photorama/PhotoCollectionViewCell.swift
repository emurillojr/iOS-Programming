//
//  PhotoCollectionViewCell.swift
//  Photorama
//
//  Created by user135340 on 2/22/18.
//  Copyright © 2018 Murillo. All rights reserved.
//

//import Foundation

import UIKit
class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    // helper method
    func update(with image: UIImage?) {
        if let imageToDisplay = image {
            spinner.stopAnimating()
            imageView.image = imageToDisplay
        } else {
            spinner.startAnimating()
            imageView.image = nil
        }
    }
    
    // reset the cell back to the spinning state
    override func awakeFromNib() {
        super.awakeFromNib()
        update(with: nil)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        update(with: nil)
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
