//
//  PointAppAPI.swift
//  PointApp
//
//  Created by Daniel Seijo Sánchez on 16/7/16.
//  Copyright © 2016 Daniel Seijo Sánchez. All rights reserved.
//

import UIKit

class PointAppAPI: NSObject {

    private let persistencyManager: PersistencyManager
    private let isOnline: Bool
    
    class var sharedInstance: PointAppAPI {
        struct Singleton {
            static let instance = PointAppAPI()
        }
        
        return Singleton.instance
    }
    
    override init() {
        persistencyManager = PersistencyManager()
        isOnline = false
        
        super.init()
    }
    
    func getPlaces() -> [Place] {
        return persistencyManager.getPlaces()
    }
    
    func addPlace(place: Place, index: Int) {
        persistencyManager.addPlace(place, index: index)
        if isOnline {
            // POST: addPlace
        }
    }
    
    func deletePlace(index: Int) {
        persistencyManager.deletePlaceAtIndex(index)
        if isOnline {
            // DELETE: deletePlaceAtIndex
        }
    }
}
