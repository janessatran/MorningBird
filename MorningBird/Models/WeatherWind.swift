//
//  WeatherWind.swift
//  MorningBird
//
//  Created by Janessa Tran on 7/18/20.
//  Copyright © 2020 Janessa Tran. All rights reserved.
//

struct WeatherWind: Codable {
    var windSpeed: Double
    var windDeg: Double

    enum CodingKeys: String, CodingKey {
        case windSpeed = "speed"
        case windDeg = "deg"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.windSpeed = try container.decode(Double.self, forKey: .windSpeed)
        self.windDeg = try container.decode(Double.self, forKey: .windDeg)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.windSpeed, forKey: .windSpeed)
        try container.encode(self.windDeg, forKey: .windDeg)
    }
}
