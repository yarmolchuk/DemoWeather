//
//  TodayViewController.swift
//  Weather Widget
//
//  Created by Dima on 15.05.15.
//  Copyright (c) 2015 Dima Yarmolchuk. All rights reserved.
//

import UIKit
import WeatherDataKit
import NotificationCenter

class TodayViewController: WeatherDataViewController, NCWidgetProviding {
    
    var latLong = "37.8267,-122.423"
    var widgetExpanded = false
    
    @IBOutlet weak var showMoreButton: UIButton!
    @IBOutlet weak var moreDetailsContainerHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moreDetailsContainerHeightConstraint.constant = 0
        
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
    
    func widgetMarginInsetsForProposedMarginInsets (defaultMarginInsets: UIEdgeInsets) -> (UIEdgeInsets) {
        return UIEdgeInsetsZero
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    
    @IBAction func showMore(sender: UIButton) {
        if widgetExpanded {
            moreDetailsContainerHeightConstraint.constant = 0
            showMoreButton.transform = CGAffineTransformMakeRotation(0)
            widgetExpanded = false
        } else {
            moreDetailsContainerHeightConstraint.constant = 220
            showMoreButton.transform = CGAffineTransformMakeRotation(CGFloat(180.0 * M_PI/180.0))
            widgetExpanded = true
        }
    }
}
