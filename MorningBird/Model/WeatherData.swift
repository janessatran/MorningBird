//
//  WeatherData.swift
//  MorningBird
//
//  Created by Janessa Tran on 7/15/20.
//  Copyright © 2020 Janessa Tran. All rights reserved.
//

import Foundation

struct WeatherData: Codable  {
    let weatherDescription: [WeatherDescription]
    let weatherDetails : WeatherDetails

    enum CodingKeys: String, CodingKey {
        case description = "weather"
        case details = "main"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.weatherDescription = try container.decode([WeatherDescription].self, forKey: .description)
        self.weatherDetails = try container.decode(WeatherDetails.self, forKey: .details)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.weatherDescription, forKey: .description)
        try container.encode(self.weatherDetails, forKey: .details)
    }
}

