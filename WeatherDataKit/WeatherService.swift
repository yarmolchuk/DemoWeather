//
//  WeatherService.swift
//  DemoWeather
//
//  Created by Dima on 15.05.15.
//  Copyright (c) 2015 Dima Yarmolchuk. All rights reserved.
//

import Foundation

class WeatherService {
    
    typealias WeatherDataCompletionBlock = (data: WeatherData?, error: NSError?) -> ()
    
    let session: NSURLSession
    
    class var sharedInstance: WeatherService {
        struct Singleton {
            static let instance = WeatherService()
        }
        return Singleton.instance
    }
    
    init() {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        session = NSURLSession(configuration: configuration)
    }
    
    func fetchWeatherData(latLong: String, completion: WeatherDataCompletionBlock) {
        let baseUrl = NSURL(string: "https://api.forecast.io/forecast/a0b79c3cbbc5403fe14e27e48cfe6ea9/\(latLong)")
        let request = NSURLRequest(URL: baseUrl!)
        let task = session.dataTaskWithRequest(request) {[unowned self] data, response, error in
            if error == nil {
                var jsonError: NSError?
                if (jsonError == nil) {
                    let weatherDictionary = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.AllowFragments, error: &jsonError) as! NSDictionary
                    
                    let data = WeatherData(weatherDictionary: weatherDictionary)
                    completion(data: data, error: nil)
                } else {
                    completion(data: nil, error: jsonError)
                }
            } else {
                completion(data: nil, error: error)
            }
        }
        task.resume()
    }
}
