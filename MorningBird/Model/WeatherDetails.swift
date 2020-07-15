//
//  WeatherDetails.swift
//  MorningBird
//
//  Created by Janessa Tran on 7/15/20.
//  Copyright © 2020 Janessa Tran. All rights reserved.
//

import Foundation

struct WeatherDetails: Codable {
    var temp: Double
    var feelsLike: Double
    var tempMin: Double
    var tempMax: Double
    var pressure: Double
    var humidity: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case humidity
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.temp = try container.decode(Double.self, forKey: .temp)
        self.feelsLike = try container.decode(Double.self, forKey: .feelsLike)
        self.tempMin = try container.decode(Double.self, forKey: .tempMin)
        self.tempMax = try container.decode(Double.self, forKey: .tempMax)
        self.pressure = try container.decode(Double.self, forKey: .pressure)
        self.humidity = try container.decode(Double.self, forKey: .humidity)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.temp, forKey: .temp)
        try container.encode(self.feelsLike, forKey: .feelsLike)
        try container.encode(self.tempMin, forKey: .tempMin)
        try container.encode(self.tempMax, forKey: .tempMax)
        try container.encode(self.pressure, forKey: .pressure)
        try container.encode(self.humidity, forKey: .humidity)

    }
}
