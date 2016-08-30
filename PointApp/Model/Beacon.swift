//
//  Beacon.swift
//  PointApp
//
//  Created by Daniel Seijo Sánchez on 29/08/16.
//  Copyright © 2016 Daniel Seijo Sánchez. All rights reserved.
//

import UIKit

class Beacon: NSObject {
    static let BASE_URL = "https://point-app-rest-api.herokuapp.com/api/"
    static let ROOT_KEY = "79edc86c9b2930aecdfcf395ffb695a0"

    var UUID: String?
    var major: Int?
    var minor: Int?
    
    var element: Element?
    
    init(UUID: String, major: Int, minor: Int) {
        self.UUID = UUID
        self.major = major
        self.minor = minor
    }
    
    static func fetchBeacon(UUID: String, major: Int, minor: Int, completionHandler: (Beacon) -> ()) {
        
        let URL = BASE_URL + "element/beacon/\(UUID)/\(major)/\(minor)"
        let request = NSMutableURLRequest(URL: NSURL(string: URL)!)
        
        let beacon = Beacon(UUID: UUID, major: major, minor: minor)
        request.addValue(ROOT_KEY, forHTTPHeaderField: "rootAuth")
        
        NSURLSession.sharedSession().dataTaskWithRequest(request) { (data,response,error) in
            
            if error != nil {
                print (error)
                return
            }
            
            do {
                let json = try(NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers))
                print(json)
                let placeInfo = json["_place"] as! [String: AnyObject]
                let place = Place(placeName: placeInfo["name"] as! String,
                                  placeDescription: placeInfo["description"] as! String,
                                  placeImg: placeInfo["image"] as! String,
                                  placeColor: placeInfo["color"] as! Int,
                                  major: placeInfo["major"] as! Int)
                
                beacon.element = Element(elementName: json["name"] as! String,
                                       elementDescription: json["description"] as! String,
                                       elementImg: json["image"] as! String,
                                       elementPlace: place,
                                       minor: json["minor"] as! Int)
                
                dispatch_async(dispatch_get_main_queue(), { 
                    completionHandler(beacon)
                })
                
            } catch let err {
                print(err)
            }
            
        }.resume()
    }
    
//    static func sampleBeacon() -> Beacon {
//        let sampleTestBeacon = Beacon(UUID: "0018B4CC-1937-4981-B893-9D7191B22E35", major: 2, minor: 1)
//        
//        let place = Place(placeName: "Cafetería", placeDescription: "Cafetería ETSIT", placeImg: "header_cafeteria", placeColor: 0xffb800, major: 2)
//        
//        sampleTestBeacon.element = Element(elementName: "Menú", elementDescription: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.", elementImg: "imgMenu", elementPlace: place, minor: 1)
//        
//        return sampleTestBeacon
//    }
}
