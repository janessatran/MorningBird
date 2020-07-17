//
//  WeatherDescription.swift
//  MorningBird
//
//  Created by Janessa Tran on 7/15/20.
//  Copyright © 2020 Janessa Tran. All rights reserved.
//

struct WeatherDescription: Codable {
    var main: String
    var description: String

    enum CodingKeys: String, CodingKey {
        case main
        case description
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.main = try container.decode(String.self, forKey: .main)
        self.description = try container.decode(String.self, forKey: .description)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.main, forKey: .main)
        try container.encode(self.description, forKey: .description)
    }
}
