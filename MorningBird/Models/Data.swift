//
//  Data.swift
//  MorningBird
//
//  Created by Janessa Tran on 7/17/20.
//  Copyright © 2020 Janessa Tran. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class Data: ObservableObject {
    @Published var weather = mainDescription
}
