//
//  Place.swift
//  PointApp
//
//  Created by Daniel Seijo Sánchez on 13/07/16.
//  Copyright © 2016 Daniel Seijo Sánchez. All rights reserved.
//

import UIKit

/**
 The Place model to receive the data from the API.
 */
class Place: NSObject {
    
    /// The Place id.
    var _id: Int?
    /// The name of the Place.
    var placeName: String?
    /// The description of the Place.
    var placeDescription: String?
    /// The image ilustrating the Place.
    var placeImg: UIImage?
    /// A color that match the image to make the app prettier.
    var placeColor: UIColor?
    /// The ID number of the place inside the App.
    var major: NSNumber?
    
    /**
     Initialize the Place object.
     
     - parameters:
        - name: The name of the Place.
        - placeDescription: The description of the Place.
        - major: The ID number of the place inside the App.
     - returns: An initialized Place object, or nil if the object could not be created for some reason that would not result in an exception.
     */
    init(placeName: String, placeDescription: String, placeImg: UIImage, placeColor: Int, major: NSNumber) {
        super.init()
        self.placeName = placeName
        self.placeDescription = placeDescription
        self.placeImg = placeImg
        self.placeColor = UIColor(netHex: placeColor)
        self.major = major
    }
    
    override var description: String {
        return "name: \(placeName)" +
            "description: \(placeDescription)" +
            "major: \(major)"
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}
