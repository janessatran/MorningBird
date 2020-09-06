//
//  AddCityView.swift
//  MorningBird
//
//  Created by Janessa Tran on 7/17/20.
//  Copyright © 2020 Janessa Tran. All rights reserved.
//

import SwiftUI

struct AddCityView: View {
    @EnvironmentObject var cityList: CityList
    @State private var search: String = ""
    @State private var isValidating: Bool = false
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var managedObjectContext

    func addUserCity(name: String) {
        let userCity = UserCity(context: managedObjectContext)
        userCity.name = name
        userCity.id = UUID()
        do {
            try managedObjectContext.save()
            print("Data saved to core data!")
        } catch {
            print(error)
        }
    }

    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Type in a city name and press 'Return'", text: $search, onCommit: {
                        self.addCity(input: self.search)
                    })
                }
            }
            .navigationBarTitle(Text("Add City"))
            .navigationBarItems(leading: cancelButton)
            .listStyle(GroupedListStyle())
        }
    }

    private var cancelButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Text("Cancel")
        }
    }

    private func addCity(input: String) {
        addUserCity(name: input)
        DispatchQueue.main.async {
//            self.cityList.cities.append(City(name: input))
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct AddCityView_Previews: PreviewProvider {
    static var previews: some View {
        AddCityView()
    }
}
