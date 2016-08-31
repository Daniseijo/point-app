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
    
//    func persist(place: Place) {
//        if place.placeName == nil || place.placeName?.characters.count == 0 {
//            return
//        }
//        
//        var places = 
//    }
    
//    - (void) persist:(Location*)location
//    {
//    if (!location || location.name == nil || location.name.length == 0) {
//    return; //input safety check
//    }
//    
//    
//    NSString* locations = [kBaseURL stringByAppendingPathComponent:kLocations];
//    
//    BOOL isExistingLocation = location._id != nil;
//    NSURL* url = isExistingLocation ? [NSURL URLWithString:[locations stringByAppendingPathComponent:location._id]] :
//    [NSURL URLWithString:locations]; //1
//    
//    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
//    request.HTTPMethod = isExistingLocation ? @"PUT" : @"POST"; //2
//    
//    NSData* data = [NSJSONSerialization dataWithJSONObject:[location toDictionary] options:0 error:NULL]; //3
//    request.HTTPBody = data;
//    
//    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"]; //4
//    
//    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
//    
//    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) { //5
//    if (!error) {
//    NSArray* responseArray = @[[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]];
//    [self parseAndAddLocations:responseArray toArray:self.objects];
//    }
//    }];
//    [dataTask resume];
//    }
    
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
