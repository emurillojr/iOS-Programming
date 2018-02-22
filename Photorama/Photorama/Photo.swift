//
//  Photo.swift
//  Photorama
//
//  Created by user135340 on 2/21/18.
//  Copyright © 2018 Murillo. All rights reserved.
//

import Foundation

// declare the Photo class with properties for the photoID, the title, and the remoteURL. Finally, add a designated initializer that sets up the instance.
class Photo {
    let title: String
    let remoteURL: URL
    let photoID: String
    let dateTaken: Date
    init(title: String, photoID: String, remoteURL: URL, dateTaken: Date) {
        self.title = title
        self.photoID = photoID
        self.remoteURL = remoteURL
        self.dateTaken = dateTaken
    }
    
    // implement the required overloading of the == operator for Equatable protocol
    //static func == (lhs: Photo, rhs: Photo) -> Bool {
        // Two Photos are the same if they have the same photoID
    //    return lhs.photoID == rhs.photoID
    //}
    
    
    
}

extension Photo: Equatable {
    static func == (lhs: Photo, rhs: Photo) -> Bool {
        // Two Photos are the same if they have the same photoID
        return lhs.photoID == rhs.photoID
    }
}