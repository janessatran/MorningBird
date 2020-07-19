//
//  Quotes.swift
//  MorningBird
//
//  Created by Janessa Tran on 7/18/20.
//  Copyright © 2020 Janessa Tran. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class Quotes: ObservableObject {
    var didChange = PassthroughSubject<City, Never>()
    private let paperQuotesURL = "https://api.paperquotes.com/apiv1/quotes/?tags=love,life&curated=1"
    let objectWillChange = ObservableObjectPublisher()

    var quote: Quote? {
        willSet {
            self.objectWillChange.send()
        }
    }

    init(name: String) {
        self.name = name
        self.getWeather()
    }

    private func getWeather() {
        let infoDict: [String: Any] = Bundle.main.infoDictionary!
        let openWeatherMapAPIKey = infoDict["Weather API Key"] as! String
        let session = URLSession.shared
        let urlString = "\(openWeatherMapBaseURL)?q=\(self.name)&appid=\(openWeatherMapAPIKey)&units=imperial"
        let formattedUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

        guard let url = URL(string: formattedUrlString!) else { return }

        let weatherRequestURL = URLRequest(url: url)
        session.dataTask(with: weatherRequestURL as URLRequest, completionHandler: { (data, response, error) in
            guard let data = data else { return }

            do {
                let decoder = JSONDecoder()
                let weatherObject = try decoder.decode(WeatherData.self, from: data)
                DispatchQueue.main.async {
                    self.weather = weatherObject
                    print(self.weather)
                }
            } catch {
                print(error.localizedDescription)
            }
            }).resume()
    }
}
