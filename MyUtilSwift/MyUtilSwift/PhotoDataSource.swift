//
//  PhotoDataSource.swift
//  MyUtilSwift
//
//  Created by SEO_MAC on 2016. 9. 2..
//  Copyright © 2016년 SEO_MAC. All rights reserved.
//

import Foundation
import UIKit

class PhotoDataSource: NSObject , UICollectionViewDataSource {
    var photos = [Photo]()
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let idendifier = "UICollectionViewCell2"
        //let cell = collectionView.dequeueReusableCellWithReuseIdentifier(idendifier, forIndexPath: indexPath)
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(idendifier, forIndexPath: indexPath) as! PhotoCollectionViewCell
        let photo = photos[indexPath.row]
        cell.updateWithImage(photo.image)
        
        return cell
    }
}
