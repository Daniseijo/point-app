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
    
    static func fetchBeacon(UUID: String, major: NSNumber, minor: NSNumber, completionHandler: @escaping (Element) -> ()) {
        
        let URL = BASE_URL + "element/beacon/\(UUID)/\(major)/\(minor)"
        let request = NSMutableURLRequest(url: Foundation.URL(string: URL)!)
        
        request.addValue(ROOT_KEY, forHTTPHeaderField: "rootAuth")
        
        URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data,response,error) in
            
            if error != nil {
                print (error)
                return
            }
            
            do {
                let jsonObject = try(JSONSerialization.jsonObject(with: data!, options: .mutableContainers))
                //print(jsonObject)
                let json = jsonObject as! NSDictionary
                
                let placeInfo = (json["_place"] as AnyObject) as! [String: AnyObject]
                
                var imagePlace = UIImage(named: "header_cafeteria")
                
                let urlImgPlace = Foundation.URL(string: placeInfo["image"] as! String)
                if let data = try? Data(contentsOf: urlImgPlace!) {
                    imagePlace = UIImage(data: data)
                }
                
                let place = Place(placeName: placeInfo["name"] as! String,
                                  placeDescription: placeInfo["description"] as! String,
                                  placeImg: imagePlace!,
                                  placeColor: placeInfo["color"] as! Int,
                                  major: placeInfo["major"] as! NSNumber)
                
                var imageElement = UIImage(named: "imgMenu")
                
                let urlImgElement = Foundation.URL(string: json["image"] as! String)
                if let data = try? Data(contentsOf: urlImgElement!) {
                    imageElement = UIImage(data: data)
                }
                
                var description = ""
                
//                if json["type"] as? String == "timetable" {
//                    let timetable = json["description"] as! [Int: AnyObject]
//                    
//                    let dayOfWeek = self.getDayOfWeek()
//                    description = timetable[dayOfWeek] as! String
//                } else {
                    description = json["description"] as! String
//                }
                let element = Element(elementName: json["name"] as! String,
                                      elementDescription: description,
                                      elementImg: imageElement!,
                                      elementPlace: place,
                                      minor: json["minor"] as! NSNumber)
                
                DispatchQueue.main.async(execute: {
                    completionHandler(element)
                })
                
            } catch let err {
                print(err)
            }
            
            }).resume()
    }
    
    static func getDayOfWeek() -> Int {
        let todayDate = Date()
        let myCalendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian)
        let myComponents = (myCalendar as NSCalendar?)?.components(.weekday, from: todayDate)
        let weekDay = myComponents?.weekday
        return weekDay!
    }
}
