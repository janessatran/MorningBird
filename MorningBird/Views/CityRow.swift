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
    @Environment(\.managedObjectContext) var managedObjectContext

    var body: some View {
        ZStack(alignment: .leading) {
            Color.flatCardBackground
            HStack {
                NavigationLink(destination: CityWeatherView(city: city).environment(\.managedObjectContext, managedObjectContext)) {
                    VStack(alignment: .leading) {
                        Text(city.name)
                            .font(.headline)
                            .fontWeight(.bold)
                            .lineLimit(2)
                            .foregroundColor(.black)
                    }
                    .padding(.horizontal, 5)
                }
            }
            .padding(25)
        }.clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

struct CityRow_Previews: PreviewProvider {
    static var previews: some View {
        CityRow(city: City(name: "Madison"))
    }
}

func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }

    if ((cString.count) != 6) {
        return UIColor.gray
    }

    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)

    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}


extension UIColor {
    static let flatBackground = UIColor(red: 255, green: 255, blue: 255)
    static let flatCardBackground = UIColor(red: 233, green: 233, blue: 233)

    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: a)
    }
}


extension Color {
    public init(decimalRed red: Double, green: Double, blue: Double) {
        self.init(red: red / 255, green: green / 255, blue: blue / 255)
    }

    public static var flatBackground: Color {
        return Color(decimalRed: 255, green: 255, blue: 255)
    }

    public static var flatCardBackground: Color {

        var myDict: NSDictionary?
        if let path = Bundle.main.path(forResource: "colors", ofType: "plist") {
            myDict = NSDictionary(contentsOfFile: path)
        }

        if myDict != nil {
            let customColor:String = myDict?["cardBackgroundColorHex"] as! String
            return Color(hexStringToUIColor(hex: customColor))
        } else {
            return Color(decimalRed: 142, green: 233, blue: 233)
        }
    }
}
