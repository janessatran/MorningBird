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
            return "-ºC"
        }
        return String(format: "%f", temperature)
    }


    var body: some View {
        ZStack {
            BackgroundGradient()
            VStack(alignment: .center) {
                Text("Current Temperature")
                    .font(.largeTitle)
                Spacer()
                HStack(alignment: .center, spacing: 16) {
                    Text(temperature)
                        .font(.title)
                }
                Spacer()
            }.frame(height: 110)
            .foregroundColor(.white)

        }
    }
}

//
//struct CityWeatherView_Previews: PreviewProvider {
//    static var previews: some View {
//        CityWeatherView(dailyWeather: WeatherDetails)
//    }
//}
