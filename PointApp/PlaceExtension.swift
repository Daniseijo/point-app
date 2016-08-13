//
//  File.swift
//  PointApp
//
//  Created by Daniel Seijo Sánchez on 16/7/16.
//  Copyright © 2016 Daniel Seijo Sánchez. All rights reserved.
//

import Foundation

extension Place {
    func pe_tableRepresentation() -> (titles:[String], values:[String]) {
        return (["Name", "Description", "Major"], [name, placeDescription, String(major)])
    }
}