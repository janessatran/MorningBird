//
//  Weather.swift
//  MorningBird
//
//  Created by Janessa Tran on 7/8/20.
//  Copyright © 2020 Janessa Tran. All rights reserved.
//

import Foundation

class Weather {

    private let openWeatherMapBaseURL = "https://api.openweathermap.org/data/2.5/weather"

    func getWeather(city: String) {
        print("Getting weather!")
        let infoDict: [String: Any] = Bundle.main.infoDictionary!
        let openWeatherMapAPIKey = infoDict["Weather API Key"] as! String
        let session = URLSession.shared
        let urlString = "\(openWeatherMapBaseURL)?q=\(city)&appid=\(openWeatherMapAPIKey)"
        print(urlString)
        let formattedUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if let url = URL(string: formattedUrlString!) {
            let weatherRequestURL = URLRequest(url: url)
            let task = session.dataTask(with: weatherRequestURL as URLRequest, completionHandler: { (data, response, error) in
                if let error = error {
                    print("Error:\n \(error)")
                }
                else {
                    print("Data:\n \(data!)")
                    self.parseData(data: data!)
                }
            })
            task.resume()
        }
    }

    func parseData(data: Data) {
        let dataString = String(data: data, encoding: String.Encoding.utf8)
        let decoder = JSONDecoder()
        print("All the weather data:\n\(dataString!)")
        do {
            let weather = try decoder.decode(WeatherData.self, from: data)
            print(weather)
        } catch {
            print(error)
        }
        
        //        if let jsonWeatherData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary {
        //            var weather = Weather()
        //
        //            if let weatherDictionary = jsonWeatherData.value(forKey: "weather") as? NSDictionary {
        //                if let data = weatherDictionary["main"] as? String {
        //                    weather.main = data
        //                }
        //                if let data = weatherDictionary["description"] as? String {
        //                    weather.description = data
        //                }
        //            }
        //
        //            if let mainDictionary = jsonWeatherData.value(forKey: "main") as? NSDictionary {
        //                if let data = mainDictionary["temp"] as? String {
        //                    weather.temp = Double(data) ?? 0.0
        //                }
        //                if let data = mainDictionary["feels_like"] as? String {
        //                    weather.feelsLike = Double(data) ?? 0.0
        //                }
        //                if let data = mainDictionary["temp_min"] as? String {
        //                    weather.tempMin = Double(data) ?? 0.0
        //                }
        //                if let data = mainDictionary["tempMax"] as? String {
        //                    weather.tempMax = Double(data) ?? 0.0
        //                }
        //                if let data = mainDictionary["humidity"] as? String {
        //                    weather.humidity = Double(data) ?? 0.0
        //                }
        //            }
        //        }
    }

}

