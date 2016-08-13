//
//  ViewController.swift
//  PointApp
//
//  Created by Daniel Seijo Sánchez on 12/07/16.
//  Copyright © 2016 Daniel Seijo Sánchez. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UITableViewDelegate {

    private var allPlaces = [Place]()
    private var currentPlaceData: (titles:[String], values:[String])?
    private var currentPlaceIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBar.translucent = false
        currentPlaceIndex = 0
        
        allPlaces = PointAppAPI.sharedInstance.getPlaces()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

