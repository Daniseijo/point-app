//
//  Element.swift
//  PointApp
//
//  Created by Daniel Seijo Sánchez on 29/08/16.
//  Copyright © 2016 Daniel Seijo Sánchez. All rights reserved.
//

import UIKit

/**
 The Element model to receive the data from the API.
 */
class Element: NSObject {
    
    /// The name of the Element.
    var elementName: String?
    /// The description of the Element.
    var elementDescription: String?
    /// The image ilustrating the Place.
    var elementImg: UIImage?
    /// The ID number of the place inside the App.
    var minor: Int?
    
    /**
     Initialize the Place object.
     
     - parameters:
     - name: The name of the Element.
     - placeDescription: The description of the Element.
     - minor: The ID number of the element inside the Place.
     - returns: An initialized Element object, or nil if the object could not be created for some reason that would not result in an exception.
     */
    init(elementName: String, elementDescription: String, elementImg: String, minor: Int) {
        super.init()
        self.elementName = elementName
        self.elementDescription = elementDescription
        self.elementImg = UIImage(named: elementImg)
        self.minor = minor
    }
    
    override var description: String {
        return "name: \(elementName)" +
            "description: \(elementDescription)" +
            "minor: \(minor)"
    }
}