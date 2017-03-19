//
//  Constants.swift
//  rainyshinycloudy
//
//  Created by Ravi Tiwari on 3/19/17.
//  Copyright © 2017 SelfStudy. All rights reserved.
//

import Foundation

let BASE_URL = "http://samples.openweathermap.org/data/2.5/"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "04af98b2e4be2e30eaa25dd8cd9aa7f2"

let REQUEST_TYPE_WEATHER = "weather?"
let REQUEST_TYPE_FORECAST = "forecast/daily?"

let CITYNAME_KEY = "name"
let WEATHER_KEY = "weather"
let WEATHER_MAIN_KEY = "main"
let MAIN_KEY = "main"
let MAIN_TEMP_KEY = "temp"
let LIST_KEY = "list"
let MIN_TEMP_KEY = "min"
let MAX_TEMP_KEY = "max"
let DATE_KEY = "dt"

let WEATHER_FORECAST_CELL_IDENTIFIER = "weatherForcastCell"

let CURRENT_WEATHER_URL = "\(BASE_URL)\(REQUEST_TYPE_WEATHER)\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(APP_ID)\(API_KEY)"
let FORECAST_WEATHER_URL = "\(BASE_URL)\(REQUEST_TYPE_FORECAST)\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\((Location.sharedInstance.longitude!))&cnt=10\(APP_ID)\(API_KEY)"

typealias DownloadComplete = () -> ()
