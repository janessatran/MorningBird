//
//  Palette.swift
//  MorningBird
//
//  Created by Janessa Tran on 7/17/20.
//  Copyright © 2020 Janessa Tran. All rights reserved.
//

import Foundation
import SwiftUI

func ColorFromRGB(rgb: UInt) -> Color {
    return Color(
        red: Double((rgb & 0xFF0000) >> 16) / 255.0,
        green: Double((rgb & 0x00FF00) >> 8) / 255.0,
        blue: Double(rgb & 0x0000FF) / 255.0
    )
}

struct Palette {
    static let color1 = ColorFromRGB(rgb: 0xeeaeca)
    static let color2 = ColorFromRGB(rgb: 0xd7b1d2)
    static let color3 = ColorFromRGB(rgb: 0xc6b4d8)
    static let color4 = ColorFromRGB(rgb: 0xb1b7df)
    static let color5 = ColorFromRGB(rgb: 0x94bbe9)
}
