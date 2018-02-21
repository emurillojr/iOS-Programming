//
//  PhotoStore.swift
//  Photorama
//
//  Created by user135340 on 2/21/18.
//  Copyright © 2018 Murillo. All rights reserved.
//

//import Foundation
import UIKit
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

class PhotoStore {
    
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
            
            let result = self.processPhotosRequest(data: data, error: error)
           OperationQueue.main.addOperation {
            completion(result)
            }
        }
        task.resume()
    }
 
    // method that will process the JSON data that is returned from the web service request
    private func processPhotosRequest(data: Data?, error: Error?) -> PhotosResult {
        guard let jsonData = data else {
            return .failure(error!)
        }
        return FlickrAPI.photos(fromJSON: jsonData)
    }
    
    // method will take in a completion closure that will return an instance of ImageResult
    func fetchImage(for photo: Photo, completion: @escaping (ImageResult) -> Void) {
        let photoURL = photo.remoteURL
        let request = URLRequest(url: photoURL)
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            
            
            let result = self.processImageRequest(data: data, error: error)
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
    
    
    
    
    
    
    
}
