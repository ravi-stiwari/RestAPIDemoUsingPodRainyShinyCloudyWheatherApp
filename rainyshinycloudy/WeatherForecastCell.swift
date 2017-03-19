//
//  WeatherForecastCell.swift
//  rainyshinycloudy
//
//  Created by Ravi Tiwari on 3/19/17.
//  Copyright © 2017 SelfStudy. All rights reserved.
//

import UIKit

class WeatherForecastCell: UITableViewCell {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    
    func configureCell(forecast: Forecast) {
        weatherIcon.image = UIImage(named: "\(forecast.weatherType) Mini")
        dayLabel.text = forecast.day
        weatherType.text = forecast.weatherType 
        highTempLabel.text = forecast.highestTemp
        lowTempLabel.text = forecast.lowestTemp
    }

}
