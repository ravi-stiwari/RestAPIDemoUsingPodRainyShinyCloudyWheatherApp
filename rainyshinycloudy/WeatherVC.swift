//
//  WeatherVC.swift
//  rainyshinycloudy
//
//  Created by Ravi Tiwari on 3/19/17.
//  Copyright © 2017 SelfStudy. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherVC: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var weatherTypeImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var weatherTypeLabel: UILabel!
    
    @IBOutlet weak var forecastTableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var currentWeather: CurrentWeather!
    var forecastWeather: Forecast!
    var forecastWeatherList = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        forecastTableView.delegate = self
        forecastTableView.dataSource = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        
        currentWeather = CurrentWeather()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationAuthStatus()
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        print("Update Failed")
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            currentWeather.downloadWeatherDetails {
                self.downloadWeatherForecast {
                    self.updateMainUI()
                    self.updateForecastDetails()
                }
            }
        }
        else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    func updateMainUI() {
        locationLabel.text = currentWeather.cityName
        dateLabel.text = currentWeather.date
        temperatureLabel.text = currentWeather.currentTemp
        weatherTypeLabel.text = currentWeather.weatherType
        weatherTypeImage.image = UIImage(named: currentWeather.weatherType)
    }
    
    func updateForecastDetails() {
        forecastTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastWeatherList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = forecastTableView.dequeueReusableCell(withIdentifier: WEATHER_FORECAST_CELL_IDENTIFIER, for: indexPath) as? WeatherForecastCell {
            cell.configureCell(forecast: forecastWeatherList[indexPath.row])
            return cell
        }
        else {
            return WeatherForecastCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func downloadWeatherForecast(completed: @escaping DownloadComplete) {
        let currentWeatherURL = URL(string: FORECAST_WEATHER_URL)!
        
        Alamofire.request(currentWeatherURL).responseJSON { response in
            if let jsonResponseDict = response.result.value as? Dictionary<String, AnyObject> {
                if let list = jsonResponseDict[LIST_KEY] as? [Dictionary<String, AnyObject>] {
                    
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecastWeatherList.append(forecast)
                    }
                }
            }
            completed()
        }
    }
}

