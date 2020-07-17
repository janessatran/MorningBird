//
//  CityListView.swift
//  MorningBird
//
//  Created by Janessa Tran on 7/17/20.
//  Copyright © 2020 Janessa Tran. All rights reserved.
//

import Foundation
import SwiftUI

struct CityListView : View {
    @EnvironmentObject var cityList: CityList
    @State var isPresentingModal: Bool = false
    @State private var isEditing: Bool = false

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Your Cities")) {
                    ForEach(self.cityList.cities, id: \.name) { city in
                        CityRow(city: city)
                    }
                    .onDelete(perform: delete)
                    .onMove(perform: move)
                }
            }
            .navigationBarItems(leading: EditButton(), trailing: addButton)
            .navigationBarTitle(Text("Cities"))
        }
    }

    private var addButton: some View {
        Button(action: {
            self.isPresentingModal = true
        }) {
            Image(systemName: "plus.circle.fill")
                .font(.title)
        }.sheet(isPresented: $isPresentingModal) {
            AddCityView().environmentObject(self.cityList)
        }
    }

    private func delete(at offsets: IndexSet) {
        if let first = offsets.first {
            self.cityList.cities.remove(at: first)
        }
        self.cityList.objectWillChange.send()
    }

    private func move(from source: IndexSet, to destination: Int) {
        if let first = source.first {
            if destination == self.cityList.cities.endIndex {
                self.cityList.cities.swapAt(first, destination - 1)
            } else {
                self.cityList.cities.swapAt(first, destination)
            }
        }
        self.cityList.objectWillChange.send()
    }

}
