//
//  JacketWornSurvey.swift
//  MorningBird
//
//  Created by Janessa Tran on 9/5/20.
//  Copyright © 2020 Janessa Tran. All rights reserved.
//

import SwiftUI

struct JacketWornSurvey: View {
    @State var city: City
    @Environment(\.managedObjectContext) var managedObjectContext
    @State private var buttonDisabled = false

    var icon: String { return "jumper" }
    
    var maxTemperature: Double {
        guard let temperature = city.weather?.weatherDetails.tempMax else {
            return 0.0
        }
        return temperature
    }

    func addData(jacketWorn: Bool) {
        let dataPoint = UserJacketData(context: managedObjectContext)
        dataPoint.jacketWorn = jacketWorn
        dataPoint.averageTemperature = maxTemperature
        dataPoint.dateAdded = Date()
        do {
            try managedObjectContext.save()
            print("Data saved to core data!")
            print("Jacket worn: \(jacketWorn)")
            print("Max Temp: \(maxTemperature)")
            print("Date Added: \(Date())")
            buttonDisabled = true

        } catch {
            print(error)
        }
    }

    var body: some View {
        VStack(alignment: .center) {
            Text("Did you wear a jacket today?")
                .fontWeight(.bold)
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)

            Image(icon)
                .multilineTextAlignment(.center)

            HStack {
                Button(action: {
                    self.addData(jacketWorn: true)
                }) {
                    HStack {
                        Image(systemName: "checkmark.circle")
                        Text("Yes").font(.title)
                    }
                }
                .buttonStyle(YesButtonStyle(buttonDisabled: $buttonDisabled))
                .frame(maxWidth: .infinity)
                .disabled(buttonDisabled)

                Button(action: {
                    self.addData(jacketWorn: false)
                }) {
                    HStack {
                        Image(systemName: "xmark.circle")
                        Text("No").font(.title)
                    }
                }
                .buttonStyle(NoButtonStyle(buttonDisabled: $buttonDisabled))
                .frame(maxWidth: .infinity)
                .disabled(buttonDisabled)

            }

            Text("Each day you can answer if you wore a jacket. We will use the data to build a recommendation model based on the average temperature to let you know in the future if you should bring a jacket with you!")
            .font(.body)
            .padding()
            .multilineTextAlignment(.center)
            .fixedSize(horizontal: false, vertical: true)
        }
    }


}

//struct JacketWornSurvey_Previews: PreviewProvider {
//    static var previews: some View {
//        JacketWornSurvey(city: )
//    }
//}

struct YesButtonStyle: ButtonStyle {
    @Binding var buttonDisabled: Bool

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.white)
            .padding()
            .background(buttonDisabled ? .gray : Palette.color1)
//            .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(15.0)
            .scaleEffect(configuration.isPressed ? 1.3 : 1.0)
    }
}

struct NoButtonStyle: ButtonStyle {
    @Binding var buttonDisabled: Bool

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.white)
            .padding()
            .background(buttonDisabled ? .gray : Palette.color5)

//            .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(15.0)
            .scaleEffect(configuration.isPressed ? 1.3 : 1.0)
    }
}
