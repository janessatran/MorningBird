//
//  City.swift
//  MorningBird
//
//  Created by Janessa Tran on 7/17/20.
//  Copyright © 2020 Janessa Tran. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class City: ObservableObject {
    var didChange = PassthroughSubject<City, Never>()
    let name: String
    let objectWillChange = ObservableObjectPublisher()

    private let openWeatherMapBaseURL = "https://api.openweathermap.org/data/2.5/weather"
    private let paperQuotesBaseURL = "https://api.paperquotes.com/apiv1/quotes/?tags=motivation&curated=1"
    let infoDict: [String: Any] = Bundle.main.infoDictionary!
    let session = URLSession.shared

    // willSet is a property observer.
    // We use it to execute code when a property has just been set,
    // so anytime weather changes, like in getWeather(), objectWillChange.send() will run.
    // It does the same thing as the @Published property wrapper
    // (it notifies any views that are observing that object that something important has changed)
    // but we have more control and can call other functions when it gets triggered.
    var weather: WeatherData? {
        willSet {
            self.objectWillChange.send()
        }
    }

    var quote: QuoteData? {
        willSet {
            self.objectWillChange.send()
        }
    }

    public func updateWeather(){
        self.getWeather()
    }

    public func updateQuote() {
        self.getQuote()
    }

    init(name: String) {
        self.name = name
        self.getWeather()
        self.getQuote()
    }

    private func getWeather() {
        let openWeatherMapAPIKey = infoDict["Weather API Key"] as! String
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
//                    print(self.weather)
                }
            } catch {
                print(error.localizedDescription)
            }
        }).resume()
    }

    private func getQuote() {
        let quoteAPIKey = infoDict["Quote API Key"] as! String
        let urlString = "\(paperQuotesBaseURL)"
        let formattedUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

        guard let url = URL(string: formattedUrlString!) else { return }

        var quotesRequestURL = URLRequest(url: url)
        quotesRequestURL.addValue("Token \(quoteAPIKey)", forHTTPHeaderField: "Authorization")

        session.dataTask(with: quotesRequestURL as URLRequest, completionHandler: { (data, response, error) in
            guard let data = data else { return }
            print(data)
            do {
                let decoder = JSONDecoder()
                let quotesObject = try decoder.decode(QuoteData.self, from: data)
                DispatchQueue.main.async {
                    self.quote = quotesObject
//                    print(self.quote)
                }
            } catch {
                print(error.localizedDescription)
            }
        }).resume()
    }
}
