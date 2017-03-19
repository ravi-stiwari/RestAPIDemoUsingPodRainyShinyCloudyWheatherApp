//
//  Forecast.swift
//  rainyshinycloudy
//
//  Created by Ravi Tiwari on 3/19/17.
//  Copyright © 2017 SelfStudy. All rights reserved.
//

import UIKit

class Forecast {
    
    var _day: String!
    var _weatherType: String!
    var _highestTemp: Double!
    var _lowestTemp: Double!
    
    var day: String {
        if _day == nil {
            _day = ""
        }
        return _day
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var highestTemp: String {
        if _highestTemp == nil {
            _highestTemp = 0.0
        }
        return "\(_highestTemp!)°C"
    }
    
    var lowestTemp: String {
        if _lowestTemp == nil {
            _lowestTemp = 0.0
        }
        return "\(_lowestTemp!)°C"
    }
    
    init(weatherDict: Dictionary<String, AnyObject>) {
        if let temp = weatherDict[MAIN_TEMP_KEY] as? Dictionary<String, AnyObject> {
            if let min = temp[MIN_TEMP_KEY] as? Double {
                self._lowestTemp = GeneralUtils.getCelsiusFromKelvinTemp(tempInKelvin: min)
            }
            if let max = temp[MAX_TEMP_KEY] as? Double {
                self._highestTemp = GeneralUtils.getCelsiusFromKelvinTemp(tempInKelvin: max)
            }
        }
        if let weather = weatherDict[WEATHER_KEY] as? [Dictionary<String, AnyObject>] {
            if let main = weather[0][MAIN_KEY] as? String {
                self._weatherType = main
            }
        }
        if let date = weatherDict[DATE_KEY] as? Double {
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            self._day = unixConvertedDate.dayOfTheWeek()
        }
    }

}

extension Date {
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
