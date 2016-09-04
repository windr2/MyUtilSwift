//
//  FlickrAPI.swift
//  MyUtilSwift
//
//  Created by SEO_MAC on 2016. 8. 29..
//  Copyright © 2016년 SEO_MAC. All rights reserved.
//

import Foundation

enum PhotosResult {
    case Success([Photo])
    case Failure(ErrorType)
}

enum FlickrError: ErrorType {
    case InvalidJSONData
}


enum Method: String{
    case RecentPhotos = "flickr.photos.getRecent"
}

class FlickrAPI {
    
    private static let baseURLString = "https://api.flickr.com/services/rest"
    private static let APIKey = "a6d819499131071f158fd740860a5a88"
    
    private static let dateFormatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    private static func flickrURL (method method: Method , parameters: [String: String]?) -> NSURL{
        let components = NSURLComponents(string: baseURLString)!
        var queryItems = [NSURLQueryItem]()
        
        let baseParams = [
            "method": method.rawValue,
            "format": "json",
            "nojsoncallback": "1",
            "api_key": APIKey
        ]
        
        for (key , value) in baseParams {
            let item = NSURLQueryItem(name: key , value: value)
            queryItems.append(item)
        }
        
        if let additionalParams = parameters {
            for (key , value) in additionalParams {
                let item = NSURLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
        }
        
        print(queryItems)
        components.queryItems = queryItems
        
        return components.URL!
    }
    
    class func recentPhotosURL() -> NSURL {
        return flickrURL(method: .RecentPhotos, parameters: ["extras": "url_h,date_taken"])
    }
    
  
    static func photosFromJSONData(data: NSData) -> PhotosResult {
        do {
            let jsonObject: AnyObject = try NSJSONSerialization.JSONObjectWithData(data, options: [])
            
            guard let
                jsonDictionary = jsonObject as? [NSObject: AnyObject],
                photos = jsonDictionary["photos"] as? [NSObject: AnyObject],
                photosArray = photos["photo"] as? [[String: AnyObject]] else{
                    
                    return .Failure(FlickrError.InvalidJSONData);
            }
            
            
            var finalPhotos = [Photo]()
            
            for photoJSON in photosArray {
                if let photo = photoFromJSONObject( photoJSON ) {
                    finalPhotos.append(photo)
                }
            }
            
            if finalPhotos.count == 0 && photosArray.count > 0 {
                return .Failure(FlickrError.InvalidJSONData)
            }
            
            return .Success(finalPhotos)
        }
        catch let error {
            return .Failure(error)
        }
    }
    
    private static func photoFromJSONObject(json: [String: AnyObject]) -> Photo? {
        guard let
            photoID = json["id"] as? String,
            title = json["title"] as? String,
            dateString = json["datetaken"] as? String,
            photoURLString = json["url_h"] as? String,
            url = NSURL(string: photoURLString),
            dateTaken = dateFormatter.dateFromString(dateString) else{
              return nil
            }
        
        print ("title: \(title)")
        return Photo(title: title , photoID: photoID , remoteURL: url , dateTaken: dateTaken)
    }
    
    
}




