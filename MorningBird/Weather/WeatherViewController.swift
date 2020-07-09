//
//  WeatherViewController.swift
//  MorningBird
//
//  Created by Janessa Tran on 7/9/20.
//  Copyright © 2020 Janessa Tran. All rights reserved.
//

import Foundation
import UIKit

class WeatherViewController: UIViewController {
    override func viewDidLoad() {
      super.viewDidLoad()
      let weather = Weather()
      weather.getWeather(city: "San Diego")
    }

}
