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
    /// The image ilustrating the Element.
    var elementImg: UIImage?
    /// The Place where the Element belongs.
    var elementPlace: Place?
    /// The ID number of the place inside the App.
    var minor: NSNumber?
    
    /**
     Initialize the Element object.
     
     - parameters:
     - elementName: The name of the Element.
     - elementDescription: The description of the Element.
     - elementImg: The image of the Element.
     - elementPlace: The linked Place of the Element.
     - minor: The ID number of the element inside the Place.
     - returns: An initialized Element object, or nil if the object could not be created for some reason that would not result in an exception.
     */
    init(elementName: String, elementDescription: String, elementImg: UIImage, elementPlace: Place, minor: NSNumber) {
        super.init()
        self.elementName = elementName
        self.elementDescription = elementDescription
        self.elementImg = elementImg
        self.elementPlace = elementPlace
        self.minor = minor
    }
    
    override var description: String {
        return "name: \(elementName)" +
            "description: \(elementDescription)" +
            "minor: \(minor)"
    }
}
