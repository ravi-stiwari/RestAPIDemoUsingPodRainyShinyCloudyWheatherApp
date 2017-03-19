//
//  Location.swift
//  rainyshinycloudy
//
//  Created by Ravi Tiwari on 3/19/17.
//  Copyright © 2017 SelfStudy. All rights reserved.
//

import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init(){}
    
    var latitude: Double!
    var longitude: Double!
}
