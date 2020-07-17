////
////  ContentView.swift
////  MorningBird
////
////  Created by Janessa Tran on 7/8/20.
////  Copyright © 2020 Janessa Tran. All rights reserved.
////
//
//import SwiftUI
//
//struct ContentView: View {
//    @EnvironmentObject var userData: UserData
////    let weather = Weather()
//    @State private var city: String = "Madison"
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            Group {
//                Text("City")
//                    .font(.callout)
//                    .bold()
//                TextField("Enter city name...", text: $city, onEditingChanged: {
//                    city in
//                }, onCommit: {
//                    self.weather.getWeather(city: self.city)
//                })
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                Text($userData.weatherData.weatherDescription.first.main)
//            }
//        }.padding()
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
