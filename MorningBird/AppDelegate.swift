//
//  AppDelegate.swift
//  MorningBird
//
//  Created by Janessa Tran on 7/8/20.
//  Copyright © 2020 Janessa Tran. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MorningBird")
        container.loadPersistentStores { description, error in
            if let error = error {
                print(error)
            }
        }
        
        return container
    }()

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Show the error here
            }
        }
    }

    func preloadCities() {
        let userCity = UserCity(context: persistentContainer.viewContext)
        userCity.name = "Madison"
        userCity.id = UUID()
        do {
            try persistentContainer.viewContext.save()
            print("Data saved to core data!")
        } catch {
            print(error)
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let defaults = UserDefaults.standard
        let isFirstLaunch = defaults.bool(forKey: "isFirstLaunch")
        if isFirstLaunch {
            preloadCities()
            defaults.set(false, forKey: "isFirstLaunch")
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: Spotify SDK

    //    let SpotifyRedirectURL = URL(string: "spotify-ios-quick-start://spotify-login-callback")!
    //    let playURI: String = ""
    //    let SpotifyClientID = "0a17fddc71d44550ba12b95fd05f1805"
    //    lazy var configuration = SPTConfiguration(
    //        clientID: SpotifyClientID,
    //        redirectURL: SpotifyRedirectURL
    //    )
    //
    //    var accessToken: String = ""
    //
    //    lazy var appRemote: SPTAppRemote = {
    //        let appRemote = SPTAppRemote(configuration: self.configuration, logLevel: .debug)
    //        appRemote.connectionParameters.accessToken = self.accessToken
    //        appRemote.delegate = self
    //        return appRemote
    //    }()
    //
    //    // get access token from spotify and save to user defaults
    //    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    //        let parameters = appRemote.authorizationParameters(from: url);
    //        if let access_token = parameters?[SPTAppRemoteAccessTokenKey] {
    //            appRemote.connectionParameters.accessToken = access_token
    //            self.accessToken = access_token
    //            let userDefaults = UserDefaults.standard
    //            userDefaults.set(access_token, forKey: "SpotifyCode")
    //        } else if let error_description = parameters?[SPTAppRemoteErrorDescriptionKey] {
    //            // Show the error
    //        }
    //        return true
    //    }
    //
    //    func connect() {
    //        self.appRemote.authorizeAndPlayURI(self.playURI)
    //    }
    //
    //    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
    //        // Connection was successful, you can begin issuing commands
    //        self.appRemote.playerAPI?.delegate = self
    //        self.appRemote.playerAPI?.subscribe(toPlayerState: { (result, error) in
    //            if let error = error {
    //                debugPrint(error.localizedDescription)
    //            }
    //        })
    //    }
    //
    //    func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
    //        debugPrint("Track name: %@", playerState.track.name)
    //    }
    //
    //    func applicationWillResignActive(_ application: UIApplication) {
    //        if self.appRemote.isConnected {
    //            self.appRemote.disconnect()
    //        }
    //    }
    //
    //    func applicationDidBecomeActive(_ application: UIApplication) {
    //        if let _ = self.appRemote.connectionParameters.accessToken {
    //            self.appRemote.connect()
    //        }
    //    }
    //
    //    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
    //        print("disconnected")
    //    }
    //    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
    //        print("failed")
    //    }

}

