//
//  ViewController.swift
//  DemoWeather
//
//  Created by Dima on 15.05.15.
//  Copyright (c) 2015 Dima Yarmolchuk. All rights reserved.
//

import UIKit
import WeatherDataKit

class ViewController: WeatherDataViewController {

    var latLong = "37.8267,-122.423"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        temperatureLabel.text = "--"
        summaryLabel.text = "--"
        timeLabel.text = "--"
        humidityLabel.text = "--"
        precipitationLabel.text = "--"
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        getWeatherData(latLong, completion: { (error) -> () in
            if error == nil {
                self.updateData()
            }
        })
    }
}

