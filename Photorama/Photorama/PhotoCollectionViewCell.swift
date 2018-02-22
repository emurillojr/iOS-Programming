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
    var photoDescription: String?
    //override the accessibilityLabel to return this string.
    override var accessibilityLabel: String? {
        get {
            return photoDescription
        }
        set {
            // Ignore attempts to set
        }
    }
    // override the accessibilityTraits property to let the system know that a cell holds an image.    
    override var accessibilityTraits: UIAccessibilityTraits {
        get {
            return super.accessibilityTraits | UIAccessibilityTraitImage
        }
        set {
            // Ignore attempts to set
        }
    }
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
    // override the isAccessibilityElement property to let the system know that each cell is accessible.
    override var isAccessibilityElement: Bool {
        get {
            return true }
        set {
            super.isAccessibilityElement = newValue
        }
    }    
    
}
