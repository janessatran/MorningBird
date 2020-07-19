//
//  QuoteData.swift
//  MorningBird
//
//  Created by Janessa Tran on 7/18/20.
//  Copyright © 2020 Janessa Tran. All rights reserved.
//

import Foundation

struct QuoteData: Codable  {
    let quote: [Quote]

    enum CodingKeys: String, CodingKey {
        case quote = "results"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.quote = try container.decode([Quote].self, forKey: .quote)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.quote, forKey: .quote)
    }
}

