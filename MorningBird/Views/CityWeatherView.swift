//
//  CityWeatherView.swift
//  MorningBird
//
//  Created by Janessa Tran on 7/17/20.
//  Copyright © 2020 Janessa Tran. All rights reserved.
//

import SwiftUI
import StoreKit

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

    let randomElement: Int = Int.random(in: 0 ... 3)

    var quote: String {
        guard let quote = city.quote?.quote[randomElement] else {
            return "\"You are awesome\""
        }
        return "\"\(quote.quote)\""
    }

    var author: String {
        guard let quote = city.quote?.quote[randomElement] else {
            return "Janessa"
        }
        return "\(quote.author)"
    }

    var appRemote: SPTAppRemote? {
        get {
            return (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.appRemote
        }
    }

    let playURI = ""
    let trackIdentifier = "spotify:track:32ftxJzxMPgUFCM6Km9WTS"
    let name = "Now Playing View"
    @State var playerState: SPTAppRemotePlayerState?
    @State var subscribedToPlayerState: Bool = false
    @State var subscribedToCapabilities: Bool = false
    @State var musicButton: String = "spotify-logo"
    @State private var showingAlert = false
    @State private var showingAppStore = false

    var defaultCallback: SPTAppRemoteCallback {
        get {
            return {[self] _, error in
                if let error = error {
                    print(error)
                }
            }
        }
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
                    Text(quote).font(.body).italic().fixedSize(horizontal: false, vertical: true).multilineTextAlignment(.center)
//                    Text(author).font(.caption).multilineTextAlignment(.center)
                }.padding(10)

                Spacer()
                Button(action: {
                    if self.appRemote?.isConnected == false {
                        if self.appRemote?.authorizeAndPlayURI(self.playURI) == false {
                            self.showingAlert = true
                            self.showingAppStore = true
                        } else {
                            self.musicButton = "pause"
                        }
                    } else {
                        self.subscribeToPlayerState()
                        //                        if self.playerState == nil || self.playerState!.isPaused {
                        if self.musicButton == "play" || self.musicButton == "spotify-logo" {
                            self.startPlayback()
                            self.musicButton = "pause"

                        } else {
                            self.pausePlayback()
                            self.musicButton = "play"
                        }
                    }
                }) {
                    if musicButton == "play" || musicButton == "pause" {
                        Image(systemName: musicButton)
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    } else {
                        Image(musicButton)
                            .foregroundColor(.white)
                    }
                }

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

                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Song of the Day"), message: Text("In order to listen to the song of the day, download Spotify from the App Store on your device!"), dismissButton: .default(Text("Got it!")))
                }

                //                .appStoreOverlay(isPresented: $showingAppStore) {
                //                    let config = SKOverlay.AppConfiguration(appIdentifier: "324684580", position: .bottom)
                //                             config.userDismissible = true
                //                    return config
                //                }
            }
        }
    }

    private func startPlayback() {
        appRemote?.playerAPI?.resume(defaultCallback)
        self.getPlayerState()

    }

    private func pausePlayback() {
        appRemote?.playerAPI?.pause(defaultCallback)
        self.getPlayerState()
    }

    private func getPlayerState() {
        appRemote?.playerAPI?.getPlayerState { (result, error) -> Void in
            guard error == nil else { return }
            self.playerState = result as! SPTAppRemotePlayerState
        }
    }

    private func subscribeToPlayerState() {
        guard (!subscribedToPlayerState) else { return }
        appRemote?.playerAPI!.delegate = SceneDelegate.init()
        appRemote?.playerAPI?.subscribe { (_, error) -> Void in
            guard error == nil else { return }
            self.subscribedToPlayerState = true
            self.updatePlayerStateSubscriptionButtonState()
        }
    }

    private func updatePlayerStateSubscriptionButtonState() {
        let playerStateSubscriptionButtonTitle = subscribedToPlayerState ? "Unsubscribe" : "Subscribe"
    }
}
