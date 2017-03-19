//
//  CurrentWeather.swift
//  rainyshinycloudy
//
//  Created by Ravi Tiwari on 3/19/17.
//  Copyright © 2017 SelfStudy. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather {
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _currentTemp: Double!
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: String {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return "\(_currentTemp!)°C"
    }
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete) {
        let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)!
        
        Alamofire.request(currentWeatherURL).responseJSON { response in
            if let jsonResponseDict = response.result.value as? Dictionary<String, AnyObject> {
                if let name = jsonResponseDict[CITYNAME_KEY] as? String {
                    self._cityName = name.capitalized
                }
                
                if let weather = jsonResponseDict[WEATHER_KEY] as? [Dictionary<String, AnyObject>] {
                    if let main = weather[0][WEATHER_MAIN_KEY] as? String {
                        self._weatherType = main.capitalized
                    }
                }
                
                if let mainTemp = jsonResponseDict[MAIN_KEY] as? Dictionary<String, AnyObject> {
                    if let currTemp = mainTemp[MAIN_TEMP_KEY] as? Double {
                        self._currentTemp = GeneralUtils.getCelsiusFromKelvinTemp(tempInKelvin: currTemp)                    }
                }
            }
            completed()
        }
    }
}
