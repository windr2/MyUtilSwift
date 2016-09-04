//
//  Photo.swift
//  MyUtilSwift
//
//  Created by SEO_MAC on 2016. 8. 29..
//  Copyright © 2016년 SEO_MAC. All rights reserved.
//

import Foundation
import UIKit

class Photo {
    let title: String
    let remoteURL: NSURL
    let photoID: String
    let dataTaken: NSDate
    var image: UIImage?
    
    init(title: String, photoID: String , remoteURL: NSURL , dateTaken: NSDate) {
        self.title = title
        self.photoID = photoID
        self.remoteURL = remoteURL
        self.dataTaken = dateTaken
    }
}

extension Photo: Equatable {}

func == (lhs: Photo, rhs: Photo) -> Bool {
    // Two Photos are the same if they have the same photoID
    return lhs.photoID == rhs.photoID
}

