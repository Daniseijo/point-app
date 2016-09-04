//
//  PointAppAPI.swift
//  PointApp
//
//  Created by Daniel Seijo Sánchez on 16/7/16.
//  Copyright © 2016 Daniel Seijo Sánchez. All rights reserved.
//

import UIKit

class PointAppAPI: NSObject {
    static let BASE_URL = "https://point-app-rest-api.herokuapp.com/api/"
    static let ROOT_KEY = "79edc86c9b2930aecdfcf395ffb695a0"
    
    static func fetchBeacon(UUID: String, major: NSNumber, minor: NSNumber, completionHandler: (Element) -> ()) {
        
        let URL = BASE_URL + "element/beacon/\(UUID)/\(major)/\(minor)"
        let request = NSMutableURLRequest(URL: NSURL(string: URL)!)
        
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
                
                var imagePlace = UIImage(named: "header_cafeteria")
                
                let urlImgPlace = NSURL(string: placeInfo["image"] as! String)
                if let data = NSData(contentsOfURL: urlImgPlace!) {
                    imagePlace = UIImage(data: data)
                }
                
                let place = Place(placeName: placeInfo["name"] as! String,
                                  placeDescription: placeInfo["description"] as! String,
                                  placeImg: imagePlace!,
                                  placeColor: placeInfo["color"] as! Int,
                                  major: placeInfo["major"] as! Int)
                
                var imageElement = UIImage(named: "imgMenu")
                
                let urlImgElement = NSURL(string: json["image"] as! String)
                if let data = NSData(contentsOfURL: urlImgElement!) {
                    imageElement = UIImage(data: data)
                }
                
                var description = ""
                
                if json["type"] as? String == "timetable" {
                    let timetable = json["description"] as! [Int: AnyObject]
                    
                    let dayOfWeek = self.getDayOfWeek()
                    description = timetable[dayOfWeek] as! String
                } else {
                    description = json["description"] as! String
                }
                let element = Element(elementName: json["name"] as! String,
                                      elementDescription: description,
                                      elementImg: imageElement!,
                                      elementPlace: place,
                                      minor: json["minor"] as! Int)
                
                dispatch_async(dispatch_get_main_queue(), {
                    completionHandler(element)
                })
                
            } catch let err {
                print(err)
            }
            
            }.resume()
    }
    
    static func getDayOfWeek() -> Int {
        let todayDate = NSDate()
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let myComponents = myCalendar?.components(.Weekday, fromDate: todayDate)
        let weekDay = myComponents?.weekday
        return weekDay!
    }
}