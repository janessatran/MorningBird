//
//  UserCity+Extensions.swift
//  MorningBird
//
//  Created by Janessa Tran on 9/5/20.
//  Copyright © 2020 Janessa Tran. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension UserCity: Identifiable {
}

extension UserCity {
  static var citiesFetchRequest: NSFetchRequest<UserCity> {
    let request: NSFetchRequest<UserCity> = UserCity.fetchRequest()
    request.sortDescriptors = [NSSortDescriptor(key: "order", ascending: true)]

    return request
  }
}
