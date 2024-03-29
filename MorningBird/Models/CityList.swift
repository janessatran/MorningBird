//
//  CityList.swift
//  MorningBird
//
//  Created by Janessa Tran on 7/17/20.
//  Copyright © 2020 Janessa Tran. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class CityList: ObservableObject {
    let didChange = PassthroughSubject<CityList, Never>()

    @Environment(\.managedObjectContext) var managedObjectContext

    var cities: [City] = [City(name: "Lake Arrowhead"), City(name: "Madison"), City(name: "San Diego")] {
        willSet {
            self.objectWillChange.send()
        }
    }
}
