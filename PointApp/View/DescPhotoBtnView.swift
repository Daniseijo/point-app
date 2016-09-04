//
//  DescPhotoImageView.swift
//  PointApp
//
//  Created by Daniel Seijo Sánchez on 11/08/16.
//  Copyright © 2016 Daniel Seijo Sánchez. All rights reserved.
//

import UIKit

class DescPhotoBtnView: UIButton {

    override func awakeFromNib() {
        self.imageView!.layer.cornerRadius = 10.0
        self.imageView!.layer.borderColor = UIColor.white.cgColor
        self.imageView!.layer.borderWidth = 3.0
    }
}
