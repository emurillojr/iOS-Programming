//
//  FlickrAPI.swift
//  Photorama
//
//  Created by user135340 on 2/21/18.
//  Copyright © 2018 Murillo. All rights reserved.
//

import Foundation
import CoreData

// declare a custom enum to represent possible errors for the Flickr API
enum FlickrError: Error {
    case invalidJSONData
}

// create the Method enumeration. Each case of Method has a raw value that matches the corresponding Flickr endpoint
enum Method: String {
    case interestingPhotos = "flickr.interestingness.getList"
}
// struct, which will contain all of the knowledge that is specific to the Flickr API
struct FlickrAPI {
    // declare a type-level property to reference the base URL string for the web service requests
    private static let baseURLString = "https://api.flickr.com/services/rest"
    private static let apiKey = "131057f3a494d23515c98eda0114b2fc"
    // an instance of DateFormatter to convert the datetaken string into an instance of Date
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    // method will return an empty URL.
    private static func flickrURL(method: Method,
                              parameters: [String:String]?) -> URL {
    //return URL(string: "")!
        var components = URLComponents(string: baseURLString)!
        var queryItems = [URLQueryItem]()
        // add the common query items to the URLComponents.
        let baseParams = [
            "method": method.rawValue,
            "format": "json",
            "nojsoncallback": "1",
            "api_key": apiKey
        ]
        for (key, value) in baseParams {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        if let additionalParams = parameters {
            for (key, value) in additionalParams {
                let item = URLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
        }
        components.queryItems = queryItems
        return components.url!
    }

    static var interestingPhotosURL: URL {
    return flickrURL(method: .interestingPhotos,
                    parameters: ["extras": "url_h,date_taken"])
    }
    // implement a method that takes in an instance of Data and uses the JSONSerialization class to convert the data into the basic foundation objects
    static func photos(fromJSON data: Data,
                       into context: NSManagedObjectContext) -> PhotosResult {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data,
                                                              options: [])
            guard
                let jsonDictionary = jsonObject as? [AnyHashable:Any],
                let photos = jsonDictionary["photos"] as? [String:Any],
                let photosArray = photos["photo"] as? [[String:Any]] else {
                    // The JSON structure doesn't match our expectations
                    return .failure(FlickrError.invalidJSONData)
            }
            var finalPhotos = [Photo]()
            for photoJSON in photosArray {
                if let photo = photo(fromJSON: photoJSON, into: context) {
                    finalPhotos.append(photo)
                }
            }
            if finalPhotos.isEmpty && !photosArray.isEmpty {
                // We weren't able to parse any of the photos
                // Maybe the JSON format for photos has changed
                return .failure(FlickrError.invalidJSONData)
            }
            return .success(finalPhotos)
        } catch let error {
            return .failure(error)
        }
    }
    
    // method to parse a JSON dictionary into a Photo instance
    private static func photo(fromJSON json: [String : Any],
                                into context: NSManagedObjectContext) -> Photo? {
        guard
            let photoID = json["id"] as? String,
            let title = json["title"] as? String,
            let dateString = json["datetaken"] as? String,
            let photoURLString = json["url_h"] as? String,
            let url = URL(string: photoURLString),
            let dateTaken = dateFormatter.date(from: dateString) else {
                // Don't have enough information to construct a Photo
                return nil
        }
        // to check whether there is an existing photo with a given ID before inserting a new one
        let fetchRequest: NSFetchRequest<Photo> = Photo.fetchRequest()
        let predicate = NSPredicate(format: "\(#keyPath(Photo.photoID)) == \(photoID)")
        fetchRequest.predicate = predicate
        var fetchedPhotos: [Photo]?
        context.performAndWait {
            fetchedPhotos = try? fetchRequest.execute()
        }
        if let existingPhoto = fetchedPhotos?.first {
            return existingPhoto
        }
        //return Photo(title: title, photoID: photoID, remoteURL: url, dateTaken: dateTaken)
        var photo: Photo!
        context.performAndWait {
            photo = Photo(context: context)
            photo.title = title
            photo.photoID = photoID
            photo.remoteURL = url as NSURL
            photo.dateTaken = dateTaken as NSDate
        }
        return photo
    }    
    
}
