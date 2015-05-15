//
//  WeatherDataViewController.swift
//  DemoWeather
//
//  Created by Dima on 15.05.15.
//  Copyright (c) 2015 Dima Yarmolchuk. All rights reserved.
//

import UIKit

class WeatherDataViewController: UIViewController {
    
    @IBOutlet internal var temperatureLabel: UILabel!
    @IBOutlet internal var summaryLabel: UILabel!
    @IBOutlet internal var timeLabel: UILabel!
    @IBOutlet internal var humidityLabel: UILabel!
    @IBOutlet internal var precipitationLabel: UILabel!
    @IBOutlet internal var locationLabel: UILabel!
    
    internal var weatherData: WeatherData?
    
    internal func updateData() {
        if let unwrappedWD = weatherData {
            
            var celciusValue = ((unwrappedWD.temperature - 32)/2)
            
            self.temperatureLabel.text =  "\(celciusValue)"
            self.summaryLabel.text =  "\(unwrappedWD.summary)"
            self.timeLabel.text =  "\(unwrappedWD.currentTime)"
            self.humidityLabel.text =  "\(unwrappedWD.humidity)"
            self.precipitationLabel.text =  "\(unwrappedWD.precipProbability)"
        }
    }
    
    internal func getWeatherData(latLong: String, completion: (error: NSError?) -> ()) {
        WeatherService.sharedInstance.fetchWeatherData(latLong, completion: { (data, error) -> () in
            dispatch_async(dispatch_get_main_queue()) {
                self.weatherData = data
                completion(error: error)
            }
        })
    }
}
