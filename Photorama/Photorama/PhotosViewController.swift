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
class PhotosViewController: UIViewController, UICollectionViewDelegate {
    //@IBOutlet var imageView: UIImageView!
    @IBOutlet var collectionView: UICollectionView!
    
    var store: PhotoStore! // add a property to hang on to an instance of PhotoStore
    let photoDataSource = PhotoDataSource()
    
    // override viewDidLoad() and fetch the interesting photos.
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = photoDataSource
        // set the PhotosViewController as the delegate of the collection view
        collectionView.delegate = self
        //store.fetchInterestingPhotos()
        
        //update the data source as soon as the view is loaded
        updateDataSource()
        
        store.fetchInterestingPhotos {
            (photosResult) -> Void in
            
            switch photosResult {
            case let .success(photos):
                print("Successfully found \(photos.count) photos.")
                
                //if let firstPhoto = photos.first {
                //    self.updateImageView(for: firstPhoto)
                //}
                
                ///////
                self.photoDataSource.photos = photos
                
            case let .failure(error):
                print("Error fetching interesting photos: \(error)")
                self.photoDataSource.photos.removeAll()
            }
            self.collectionView.reloadSections(IndexSet(integer: 0))
        }
    }

    // method that will fetch the image and display it on the image view
//    func updateImageView(for photo: Photo) {
//        store.fetchImage(for: photo) {
//            (imageResult) -> Void in
//            switch imageResult {
//            case let .success(image):
//                self.imageView.image = image
//            case let .failure(error):
//                print("Error downloading image: \(error)")
//            }
//        }
//    }

    // implement the delegate method in PhotosViewController.swift.
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        let photo = photoDataSource.photos[indexPath.row]
        // Download the image data, which could take some time
        store.fetchImage(for: photo) { (result) -> Void in
            // The index path for the photo might have changed between the
            // time the request started and finished, so find the most
            // recent index path
            // (Note: You will have an error on the next line; you will fix it soon)
            guard let photoIndex = self.photoDataSource.photos.index(of: photo),
                case let .success(image) = result else {
                    return
            }
            let photoIndexPath = IndexPath(item: photoIndex, section: 0)
            
            // When the request finishes, only update the cell if it's still visible
            if let cell = self.collectionView.cellForItem(at: photoIndexPath)
                                                        as? PhotoCollectionViewCell {
            cell.update(with: image)
            }
        }
    }
    
    
    // implement prepare(for:sender:) to pass along the photo and the store
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showPhoto"?:
            if let selectedIndexPath =
                collectionView.indexPathsForSelectedItems?.first {
                let photo = photoDataSource.photos[selectedIndexPath.row]
                let destinationVC = segue.destination as! PhotoInfoViewController
                destinationVC.photo = photo
                destinationVC.store = store
            }
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }

    
    //add a new method that will update the data source with all of the photos.
    private func updateDataSource() {
        store.fetchAllPhotos {
            (photosResult) in
            switch photosResult {
            case let .success(photos):
                self.photoDataSource.photos = photos
            case .failure:
                self.photoDataSource.photos.removeAll()
            }
            self.collectionView.reloadSections(IndexSet(integer: 0))
        }
    }
    

}
    
    
    
    
    
    
    

