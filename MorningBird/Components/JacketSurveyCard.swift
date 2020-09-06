//
//  JacketSurveyCard.swift
//  MorningBird
//
//  Created by Janessa Tran on 9/6/20.
//  Copyright © 2020 Janessa Tran. All rights reserved.
//

import SwiftUI

struct JacketSurveyCard: View {
    let city: City
    
    @State private var buttonDisabled = false
    @State var userAnswer: Bool = false
    @State var isPresentingModal: Bool = false
    @State private var showingAlert = false
    @Environment(\.managedObjectContext) var managedObjectContext

    @FetchRequest(fetchRequest: UserJacketData.currentDataFetchRequest)
    var userJacketData: FetchedResults<UserJacketData>

    private var learnMoreButton: some View {
        Button(action: {
            self.isPresentingModal = true
        }) {
            Image(systemName: "info.circle")
                .font(.title)

        }.sheet(isPresented: $isPresentingModal) {
            Text("About Jacket Recommendations").font(.headline)
            Text("Each day you can answer if you wore a jacket. We will use the data to build a recommendation model based on the average temperature to let you know in the future if you should bring a jacket with you!")
                .font(.body)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .padding(20)
        }.frame(minWidth: 30, maxWidth: .infinity)
    }

    var maxTemperature: Double {
        guard let temperature = city.weather?.weatherDetails.tempMax else {
            return 0.0
        }
        return temperature
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            BackgroundGradient()
            VStack(alignment: .center) {
                Text("Did you wear a jacket today?")
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .navigationBarItems(trailing: learnMoreButton)
                    .alert(isPresented: $showingAlert) {
                        Alert(
                            title: Text("Answer already recorded for today"),
                            message: Text("An answer has already been recorded for you today. If you would like to proceed in overwriting your answer, click Yes, otherwise click Cancel"),
                            primaryButton: .default(
                                Text("Yes"),
                                action: { self.addData(jacketWorn: self.userAnswer)}
                            ),
                            secondaryButton: .default(Text("Cancel")))
                }
                Spacer().frame(height: 50)

                HStack {
                    Button(action: {
                        self.checkDataForCurrentDate()
                        self.userAnswer = true
                    }) {
                        HStack {
                            Image(systemName: "checkmark.circle")
                            Text("Yes").font(.body)
                        }
                    }
                    .buttonStyle(YesButtonStyle(buttonDisabled: $buttonDisabled))
                    .frame(maxWidth: .infinity)
                    .disabled(buttonDisabled)
                    Button(action: {
                        self.checkDataForCurrentDate()
                        self.userAnswer = false
                    }) {
                        HStack {
                            Image(systemName: "xmark.circle")
                            Text("No").font(.body)
                        }
                    }
                    .buttonStyle(NoButtonStyle(buttonDisabled: $buttonDisabled))
                    .frame(maxWidth: .infinity)
                    .disabled(buttonDisabled)
                }
            }
            .padding(25)
            .frame(minWidth: 100, maxWidth: .infinity, minHeight: 200, maxHeight: 400)
            Spacer()
            Spacer()
        }
        .padding(25)
        .frame(maxHeight: 500)
    }

    func checkDataForCurrentDate() {
        if userJacketData.count != 0 {
            self.showingAlert = true
        } else {
            self.addData(jacketWorn: self.userAnswer)
        }
    }

    func addData(jacketWorn: Bool)  {
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
}

struct YesButtonStyle: ButtonStyle {
    @Binding var buttonDisabled: Bool

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.black)
            .padding()
            .background(buttonDisabled ? .gray : Color.white)
            //            .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(15.0)
            .scaleEffect(configuration.isPressed ? 1.3 : 1.0)
    }
}

struct NoButtonStyle: ButtonStyle {
    @Binding var buttonDisabled: Bool

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.black)
            .padding()
            .background(buttonDisabled ? .gray : Color.white)

            //            .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(15.0)
            .scaleEffect(configuration.isPressed ? 1.3 : 1.0)
    }
}
