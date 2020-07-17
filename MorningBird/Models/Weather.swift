////
////  Weather.swift
////  MorningBird
////
////  Created by Janessa Tran on 7/8/20.
////  Copyright © 2020 Janessa Tran. All rights reserved.
////
//import Combine
//import Foundation
//
////let forecast = Weather().getWeather(city: "Lake Arrowhead")
//
//class Weather {
//    var mainDescription: String = ""
//    private let openWeatherMapBaseURL = "https://api.openweathermap.org/data/2.5/weather"
//
//    func getWeather(city: String) {
//        let infoDict: [String: Any] = Bundle.main.infoDictionary!
//        let openWeatherMapAPIKey = infoDict["Weather API Key"] as! String
//        let session = URLSession.shared
//        let urlString = "\(openWeatherMapBaseURL)?q=\(city)&appid=\(openWeatherMapAPIKey)"
//        let formattedUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//        if let url = URL(string: formattedUrlString!) {
//            let weatherRequestURL = URLRequest(url: url)
//            let task = session.dataTask(with: weatherRequestURL as URLRequest, completionHandler: { (data, response, error) in
//                if let error = error {
//                    print("Error:\n \(error)")
//                }
//                else {
//                    self.parseData(data: data!)
//                }
//            })
//            task.resume()
//        }
//    }
//
//    func parseData(data: Data) {
//        let decoder = JSONDecoder()
//        DispatchQueue.main.async {
//            do {
//                try decoder.decode(WeatherData.self, from: data)
//            } catch {
//                print(error)
//            }
//        }
//    }
//}
//
