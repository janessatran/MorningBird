//
//  UserJacketData+Extensions.swift
//  MorningBird
//
//  Created by Janessa Tran on 9/5/20.
//  Copyright © 2020 Janessa Tran. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension UserJacketData: Identifiable {
}

extension UserJacketData {
  static var currentDataFetchRequest: NSFetchRequest<UserJacketData> {
    let request: NSFetchRequest<UserJacketData> = UserJacketData.fetchRequest()
    request.predicate = NSPredicate(format: "dateAdded <= %@ || dateAdded >= %@", Date().endOfDay as CVarArg, Date().startOfDay as CVarArg)
    request.sortDescriptors = [NSSortDescriptor(key: "dateAdded", ascending: true)]

    return request
  }

    static var jacketWornFetchRequest: NSFetchRequest<UserJacketData> {
        let request: NSFetchRequest<UserJacketData> = UserJacketData.fetchRequest()
        request.propertiesToFetch = ["jacketWorn", "dateAdded"]
        request.sortDescriptors = [NSSortDescriptor(key: "dateAdded", ascending: true)]
        return request
    }

    static var averageTempFetchRequest: NSFetchRequest<UserJacketData> {
        let request: NSFetchRequest<UserJacketData> = UserJacketData.fetchRequest()
        request.propertiesToFetch = ["averageTemperature", "dateAdded"]
        request.sortDescriptors = [NSSortDescriptor(key: "dateAdded", ascending: true)]
        return request
    }
}


extension Date {
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }

    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
}
