//
//  PhotoStore.swift
//  Photorama
//
//  Created by user135340 on 2/21/18.
//  Copyright © 2018 Murillo. All rights reserved.
//

//import Foundation
import UIKit
import CoreData

enum ImageResult {
    case success(UIImage)
    case failure(Error)
}
enum PhotoError: Error {
    case imageCreationError
}
// add an enumeration named PhotosResult to the top of the file that has a case for both success and failure
enum PhotosResult {
    case success([Photo])
    case failure(Error)
}
// define a new result type at the top for use when fetching tags
enum TagsResult {
    case success([Tag])
    case failure(Error)
}

class PhotoStore {
    let imageStore = ImageStore()
    // add a property to hold on to an instance of NSPersistentContainer
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Photorama")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error setting up Core Data (\(error)).")
            }
        }
        return container
    }()
    // add a property to hold on to an instance of URLSession
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    // implement the fetchInterestingPhotos() method to create a URLRequest that connects to api.flickr.com and asks for the list of interesting photos. Then, use the URLSession to create a URLSessionDataTask that transfers this request to the server.
    func fetchInterestingPhotos(completion: @escaping (PhotosResult) -> Void) {
        let url = FlickrAPI.interestingPhotosURL
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            
            //if let jsonData = data {
                //if let jsonString = String(data: jsonData,
                //                           encoding: .utf8) {
                //    print(jsonString)
                //}
                
                // print the JSON object to the console
            //    do{
            //        let jsonObject = try JSONSerialization.jsonObject(with: jsonData,
            //                                                          options:[])
            //        print(jsonObject)
            //    } catch let error {
            //        print("Error creating JSON object: \(error)")
            //    }
            //} else if let requestError = error {
            //    print("Error fetching interesting photos: \(requestError)")
            //} else {
            //    print("Unexpected error with the request")
            //}
            
            //var result = self.processPhotosRequest(data: data, error: error)
            //if case .success = result {
             //   do {
             //       try self.persistentContainer.viewContext.save()
             //   } catch let error {
             //       result = .failure(error)
              //  }
           // }
           //OperationQueue.main.addOperation {
            //completion(result)
            //}
            self.processPhotosRequest(data: data, error: error) {
                (result) in
                OperationQueue.main.addOperation {
                    completion(result)
                }
            }           
        }
        task.resume()
    }
 
    // method that will process the JSON data that is returned from the web service request
    //private func processPhotosRequest(data: Data?, error: Error?) -> PhotosResult {
    private func processPhotosRequest(data: Data?,
                                      error: Error?,
                                      completion: @escaping (PhotosResult) -> Void) {
    guard let jsonData = data else {
            //return .failure(error!)
        completion(.failure(error!))
        return
        }
        //return FlickrAPI.photos(fromJSON: jsonData,
        //                        into: persistentContainer.viewContext)
        persistentContainer.performBackgroundTask {
            (context) in
            let result = FlickrAPI.photos(fromJSON: jsonData, into: context)
            do {
                try context.save()
            } catch {
                print("Error saving to Core Data: \(error).")
                completion(.failure(error))
                return
            }
            switch result {
            case let .success(photos):
                let photoIDs = photos.map { return $0.objectID }
                let viewContext = self.persistentContainer.viewContext
                let viewContextPhotos =
                    photoIDs.map { return viewContext.object(with: $0) } as! [Photo]
                completion(.success(viewContextPhotos))
            case .failure:
                completion(result)
            }
        }
    }
    
    // method will take in a completion closure that will return an instance of ImageResult
    func fetchImage(for photo: Photo, completion: @escaping (ImageResult) -> Void) {
        guard let photoKey = photo.photoID else {
            preconditionFailure("Photo expected to have a photoID.")
        }
        if let image = imageStore.image(forKey: photoKey) {
            OperationQueue.main.addOperation {
                completion(.success(image))
            }
            return
        }
        guard let photoURL = photo.remoteURL else {
            preconditionFailure("Photo expected to have a remote URL.")
        }
        let request = URLRequest(url: photoURL as URL)
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            let result = self.processImageRequest(data: data, error: error)
            if case let .success(image) = result {
                self.imageStore.setImage(image, forKey: photoKey)
            }
            OperationQueue.main.addOperation {
            completion(result)
            }
        }
        task.resume()
    }
    
    // implement a method that processes the data from the web service request into an image, if possible
    private func processImageRequest(data: Data?, error: Error?) -> ImageResult {
        guard
            let imageData = data,
            let image = UIImage(data: imageData) else {        
        // Couldn't create an image
        if data == nil {
            return .failure(error!)
        } else {
            return .failure(PhotoError.imageCreationError)
            }
        }
        return .success(image)
    }
    
    //implement a method that will fetch the Photo instances from the view context.
    func fetchAllPhotos(completion: @escaping (PhotosResult) -> Void) {
        let fetchRequest: NSFetchRequest<Photo> = Photo.fetchRequest()
        let sortByDateTaken = NSSortDescriptor(key: #keyPath(Photo.dateTaken),
                                               ascending: true)
        fetchRequest.sortDescriptors = [sortByDateTaken]
        let viewContext = persistentContainer.viewContext
        viewContext.perform {
            do {
                let allPhotos = try viewContext.fetch(fetchRequest)
                completion(.success(allPhotos))
            } catch {
                completion(.failure(error))
            }
        }        
    }
    
    // define a new method that fetches all the tags from the view context.
    func fetchAllTags(completion: @escaping (TagsResult) -> Void) {
        let fetchRequest: NSFetchRequest<Tag> = Tag.fetchRequest()
        let sortByName = NSSortDescriptor(key: #keyPath(Tag.name), ascending: true)
        fetchRequest.sortDescriptors = [sortByName]
        let viewContext = persistentContainer.viewContext
        viewContext.perform {
            do {
                let allTags = try fetchRequest.execute()
                completion(.success(allTags))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
}
