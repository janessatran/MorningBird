//
//  CityWeatherView.swift
//  MorningBird
//
//  Created by Janessa Tran on 7/17/20.
//  Copyright © 2020 Janessa Tran. All rights reserved.
//

import SwiftUI

struct CityWeatherView: View {
    @State var city: City

    var temperature: String {
        guard let temperature = city.weather?.weatherDetails.temp else {
            return "-ºF"
        }
        return String(format: "%.1f", temperature) + " ºF"
    }

    var mainDescription: String {
        guard let mainDescription = city.weather?.weatherDescription.first?.main else {
            return ""
        }
        return mainDescription
    }

    var description: String {
        guard let mainDescription = city.weather?.weatherDescription.first?.description else {
            return ""
        }
        return mainDescription
    }

    var feelsLike: [String:String] {
        let title = "Feels Like"
        guard let feelsLike = city.weather?.weatherDetails.feelsLike else {
            return ["title": title, "temp": ""]
        }
        return ["title": title, "temp" : String(format: "%.1f", feelsLike) + " ºF"]
    }

    var minTemp: [String:String] {
        let title = "Min Temp."
        guard let minTemp = city.weather?.weatherDetails.tempMin else {
            return ["title": title, "data": ""]
        }
        return ["title": title, "temp" : String(format: "%.1f", minTemp) + " ºF"]
    }

    var maxTemp: [String:String] {
        let title = "Max Temp."
        guard let maxTemp = city.weather?.weatherDetails.tempMax else {
            return ["title": title, "data": ""]
        }
        return ["title": title, "temp" : String(format: "%.1f", maxTemp) + " ºF"]
    }

    var pressure: [String:String] {
        let title = "Pressure"
        guard let pressure = city.weather?.weatherDetails.pressure else {
            return ["title": title, "data": ""]
        }
        return ["title": title, "temp" : String(format: "%.1f", pressure) + " hPa"]
    }

    var humidity: [String:String] {
        let title = "Humidity"
        guard let humidity = city.weather?.weatherDetails.humidity else {
            return ["title": title, "data": ""]
        }
        return ["title": title, "temp" : String(format: "%.1f", humidity) + "%"]
    }

    var windSpeed: [String:String] {
        let title = "Wind Speed"
        guard let windSpeed = city.weather?.weatherWind.windSpeed else {
            return ["title": title, "data": ""]
        }
        return ["title": title, "temp" : String(format: "%.1f", windSpeed) + "mph"]
    }

    var windDeg: [String:String] {
        let title = "Wind Deg."
        guard let windDeg = city.weather?.weatherWind.windDeg else {
            return ["title": title, "data": ""]
        }
        return ["title": title, "temp" : String(format: "%.1f", windDeg) + "º"]
    }

    // icons from https://icons8.com/icon/pack/weather/doodle
    var icon: String {
        switch mainDescription {
        case "Clear": return "sun"
        case "Clouds": return "partly-cloudy-day"
        case "Thunderstorm": return "cloud-lightning"
        case "Drizzle" : return "rain"
        case "Rain" : return "rain"
        case "Snow" : return "snow"
        default: return "moon-and-sun"
        }
    }

    var quote: String {
        guard let quote = city.quote?.quote.last else {
            return "\"You are awesome\""
        }
        return "\"\(quote.quote)\""
    }

    var author: String {
        guard let quote = city.quote?.quote.last else {
            return "Janessa"
        }
        return "\(quote.author)"
    }

    var body: some View {
        ZStack {
            BackgroundGradient()
            VStack(alignment: .center) {
                Text(city.name).fontWeight(.bold).font(.largeTitle)
                Image(icon)
                Text(temperature).font(.title)
                Text(description).font(.caption)
                Spacer()
                VStack(alignment: .center) {
                    Text(quote).font(.title).italic().multilineTextAlignment(.center)
                    Text(author).font(.caption).multilineTextAlignment(.center)
                }.padding(10)
                Spacer()
                HStack(alignment: .center, spacing: 16) {
                    ScrollView(.horizontal) {
                        HStack(spacing: 12) {
                            ForEach([feelsLike, minTemp, maxTemp, pressure, humidity, windSpeed, windDeg], id: \.self) { data in
                                DetailButtons(title: data["title"]!, temp: data["temp"]!)
                            }
                        }
                        .padding()
                        .cornerRadius(32)
                    }.padding(.bottom)
                }
            }

        }
    }
}

//
//struct CityWeatherView_Previews: PreviewProvider {
//    static var previews: some View {
//        CityWeatherView(dailyWeather: WeatherDetails)
//    }
//}
