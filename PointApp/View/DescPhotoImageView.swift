//
//  DescPhotoImageView.swift
//  PointApp
//
//  Created by Daniel Seijo Sánchez on 11/08/16.
//  Copyright © 2016 Daniel Seijo Sánchez. All rights reserved.
//

import UIKit

class DescPhotoImageView: UIImageView {

    override func awakeFromNib() {
        self.layer.cornerRadius = 10.0
        self.layer.borderColor = UIColor.whiteColor().CGColor
        self.layer.borderWidth = 3.0
    }
}
