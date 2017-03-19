//
//  GeneralUtils.swift
//  rainyshinycloudy
//
//  Created by Ravi Tiwari on 3/19/17.
//  Copyright © 2017 SelfStudy. All rights reserved.
//

import Foundation

class GeneralUtils {
    static func getCelsiusFromKelvinTemp(tempInKelvin: Double) -> Double {
        return Double(round(100*(tempInKelvin - 273.15))/100)
    }
}
