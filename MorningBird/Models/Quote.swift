//
//  Quote.swift
//  MorningBird
//
//  Created by Janessa Tran on 7/18/20.
//  Copyright © 2020 Janessa Tran. All rights reserved.
//

import Foundation

struct Quote: Codable {
    var quote: String
    var author: String

    enum CodingKeys: String, CodingKey {
        case quote
        case author
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.quote = try container.decode(String.self, forKey: .quote)
        self.author = try container.decode(String.self, forKey: .author)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.quote, forKey: .quote)
        try container.encode(self.author, forKey: .author)
    }
}
