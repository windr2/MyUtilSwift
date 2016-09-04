//
//  PhotosViewController.swift
//  MyUtilSwift
//
//  Created by SEO_MAC on 2016. 8. 29..
//  Copyright © 2016년 SEO_MAC. All rights reserved.
//

import Foundation
import UIKit


class PhotosViewController: UIViewController , UICollectionViewDelegate{
    
    //@IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet var collectionView: UICollectionView!
    
    var store: PhotoStore!
    let photoDataSource = PhotoDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = photoDataSource
        collectionView.delegate = self
        
        store = PhotoStore()
        store.fetchRecentPhotos(){
            (photosResult) -> Void in
            
            NSOperationQueue.mainQueue().addOperationWithBlock() {
                switch photosResult {
                case let .Success(photos):
                    self.photoDataSource.photos = photos
                    print("Successfully found \(photos.count) recent photos.")
               
                case let .Failure(error):
                    self.photoDataSource.photos.removeAll()
                    print("Error fetching recent photos: \(error)")
               
                }
            
            //self.collectionView.reloadSections(NSIndexSet(index: 0))
            self.collectionView.reloadSections(NSIndexSet(index: 0))
                
            }
        }
    }
    
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        let photo = photoDataSource.photos[indexPath.row]
        
        store.fetchImageForPhoto(photo){
            (result) -> Void in
            
            NSOperationQueue.mainQueue().addOperationWithBlock(){
                
                let photoIndex = self.photoDataSource.photos.indexOf(photo)!
                let photoIndexPath = NSIndexPath(forRow: photoIndex , inSection: 0)
                
                if let cell = self.collectionView.cellForItemAtIndexPath(photoIndexPath) as? PhotoCollectionViewCell{
                     cell.updateWithImage(photo.image)
                }
                
                
                
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}









