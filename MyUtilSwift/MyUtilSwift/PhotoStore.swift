//
//  PhotoStore.swift
//  MyUtilSwift
//
//  Created by SEO_MAC on 2016. 8. 29..
//  Copyright © 2016년 SEO_MAC. All rights reserved.
//

import Foundation
import UIKit

enum ImageResult {
    case Success(UIImage)
    case Failure(ErrorType)
}

enum PhotoError: ErrorType {
    case ImageCreationError
}

class PhotoStore {
    
    let session: NSURLSession = {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        return NSURLSession(configuration: config)
    }()
    
    //func fetchRecentPhotos() {
    func fetchRecentPhotos( completion completion: (PhotosResult) -> Void ) {
        
        let url = FlickrAPI.recentPhotosURL()
        let request = NSURLRequest(URL: url)
        
        print("서버 요청 : \(url)")
        
        let task = session.dataTaskWithRequest(request){
            (data , response , error) -> Void in
            
            if let jsonData = data {
                let result = self.processRecentPhotosRequest(data: jsonData, error: error)
                
                completion(result)
            }
        }
        task.resume()
    }
    
    func processImageRequest(data data: NSData? , error: NSError?) -> ImageResult {
        guard let
            imageData = data,
            image = UIImage(data: imageData) else {
                if data == nil {
                    return .Failure(error!)
                }else{
                    return .Failure(PhotoError.ImageCreationError)
                }
        }
        return .Success(image)
    }
    
    func fetchImageForPhoto(photo: Photo , completion: (ImageResult -> Void )){
        if let image = photo.image {
            completion(.Success(image))
            return
        }
        
        let photoURL = photo.remoteURL
        let request = NSURLRequest(URL: photoURL)
        
        let task = session.dataTaskWithRequest(request){
            (data , response , error) -> Void in
            
            let result = self.processImageRequest(data: data, error: error)
            
            if case let .Success(image) = result{
                photo.image = image
            }
            
            completion(result)
        }
        task.resume()
        
    }
    
    func processRecentPhotosRequest(data data: NSData? , error: NSError? ) -> PhotosResult{
        guard let jsonData = data else{
            return .Failure(error!)
        }
        
        return FlickrAPI.photosFromJSONData(jsonData)
    }
    
}





