//
//  PhotoCollectionViewCell.swift
//  MyUtilSwift
//
//  Created by SEO_MAC on 2016. 9. 2..
//  Copyright © 2016년 SEO_MAC. All rights reserved.
//

import Foundation
import UIKit

class PhotoCollectionViewCell: UICollectionViewCell{
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var spinner: UIActivityIndicatorView!
    @IBOutlet var label: UILabel!
    
    func updateWithImage(image: UIImage?){
        if let imageToDisply = image {
            spinner.stopAnimating()
            imageView.image = imageToDisply
        }else{
            spinner.startAnimating()
            imageView.image = nil
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        updateWithImage(nil)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        updateWithImage(nil)
    }
}

