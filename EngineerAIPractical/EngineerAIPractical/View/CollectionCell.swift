//
//  CollectionCell.swift
//  EngineerAIPractical
//
//  Created by Vipul on 30/12/19.
//  Copyright © 2019 Vipul. All rights reserved.
//

import UIKit
import SDWebImage

class CollectionCell: UICollectionViewCell {
    
    @IBOutlet private var imgView : UIImageView!
    @IBOutlet private var activityIndicator : UIActivityIndicatorView!
    
    var setImage : String = ""  {
        didSet {
            self.activityIndicator.startAnimating()
            self.imgView.sd_setImage(with: URL(string: setImage)) { (img, error, type, url) in
                self.activityIndicator.stopAnimating()
            }
        }
    }
}
