//
//  PersistencyManager.swift
//  PointApp
//
//  Created by Daniel Seijo Sánchez on 16/7/16.
//  Copyright © 2016 Daniel Seijo Sánchez. All rights reserved.
//

import UIKit

class PersistencyManager: NSObject {

    private var places = [Place]()
    
    override init() {
        let place1 = Place(placeName: "Cafetería",
                           placeDescription: "Cafetería de la ETSIT",
                           placeImg: "header_museo",
                           major: 1)
        let place2 = Place(placeName: "Museo",
                           placeDescription: "Museo de la ETSIT",
                           placeImg: "header_museo",
                           major: 2)
        let place3 = Place(placeName: "Clases",
                           placeDescription: "Clases en la ETSIT",
                           placeImg: "header_museo",
                           major: 3)
        
        places = [place1, place2, place3]
    }
    
    func getPlaces() -> [Place] {
        return places
    }
    
    func addPlace(place: Place, index: Int) {
        if places.count >= index {
            places.insert(place, atIndex: index)
        } else {
            places.append(place)
        }
    }
    
    func deletePlaceAtIndex(index: Int) {
        places.removeAtIndex(index)
    }
}
