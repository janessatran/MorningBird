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
        return Color(decimalRed: 233, green: 233, blue: 233)
        //        return Color(decimalRed: 148, green: 187, blue: 233)
    }
}
