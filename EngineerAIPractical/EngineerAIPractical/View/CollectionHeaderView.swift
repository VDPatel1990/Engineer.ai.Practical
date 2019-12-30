//
//  CollectionHeaderView.swift
//  EngineerAIPractical
//
//  Created by Vipul on 30/12/19.
//  Copyright © 2019 Vipul. All rights reserved.
//

import UIKit

final class CollectionHeaderView: UICollectionReusableView {
    
    //MARK :- Outlets
    @IBOutlet private weak var imgUser : UIImageView!
    @IBOutlet private weak var labelName : UILabel!
    @IBOutlet private weak var activityView : UIActivityIndicatorView!
    
    //MARK :- Variabels
    var user : Users! {
        didSet {
            self.labelName.text = user.name
            self.activityView.startAnimating()
            self.imgUser.sd_setImage(with: URL(string: user.image)) { (img, error, type, url) in
                self.activityView.stopAnimating()
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imgUser.layer.cornerRadius = self.imgUser.frame.width / 2.0
        self.imgUser.clipsToBounds = true
    }
}
