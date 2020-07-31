//
//  CityRow.swift
//  MorningBird
//
//  Created by Janessa Tran on 7/17/20.
//  Copyright © 2020 Janessa Tran. All rights reserved.
//

import SwiftUI

struct CityRow: View {
    @ObservedObject var city: City

    var body: some View {
        NavigationLink(destination: CityWeatherView(city: city)) {
            HStack(alignment: .firstTextBaseline) {
                Text(city.name)
                .lineLimit(nil)
                    .font(.title)
                Spacer()
            }.onAppear {
                self.city.updateWeather()
            }
        }
    }
}

struct CityRow_Previews: PreviewProvider {
    static var previews: some View {
        CityRow(city: City(name: "Madison"))
    }
}
