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

    init() {
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = .flatBackground
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(self.cityList.cities, id: \.name) { city in
                    CityRow(city: city)
                }
                .onDelete(perform: delete)
                .onMove(perform: move)
            }
            .navigationBarItems(leading: EditButton(), trailing: addButton)
            .navigationBarTitle(Text("Cities"))
        }.accentColor(.black)
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
        self.cityList.cities.move(fromOffsets: source, toOffset: destination)
        if isEditing == false {
            self.cityList.objectWillChange.send()
        }
    }

}
