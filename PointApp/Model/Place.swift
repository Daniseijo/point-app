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
    
    /// The name of the Place.
    var name: String!
    /// The description of the Place.
    var placeDescription: String!
    /// The ID number of the place inside the App.
    var major: Int!
    
    /**
     Initialize the Place object.
     
     - parameters:
        - name: The name of the Place.
        - placeDescription: The description of the Place.
        - major: The ID number of the place inside the App.
     - returns: An initialized Place object, or nil if the object could not be created for some reason that would not result in an exception.
     */
    init(name: String, placeDescription: String, major: Int) {
        super.init()
        self.name = name
        self.placeDescription = placeDescription
        self.major = major
    }
    
    override var description: String {
        return "name: \(name)" +
            "description: \(placeDescription)" +
            "major: \(major)"
    }
}
