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
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: UserCity.citiesFetchRequest)
    var userCities: FetchedResults<UserCity>

    init() {
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = .flatBackground
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(userCities, id: \.id) { city in
                    CityRow(city: City(name: city.name!)).environment(\.managedObjectContext, self.managedObjectContext)
                }
                .onDelete(perform: delete)
                .onMove(perform: move)
            }
            .navigationBarItems(
                leading: EditButton(),
                trailing: addButton)
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
            AddCityView().environment(\.managedObjectContext, self.managedObjectContext)
            //                .environmentObject(self.cityList)
        }.frame(minWidth: 30, maxWidth: .infinity)
    }

    private func delete(at offsets: IndexSet) {
        for index in offsets {
            let userCity = userCities[index]
            managedObjectContext.delete(userCity)
            //            self.cityList.cities.remove(at: first)
        }
        saveObjectContext()
        //        self.cityList.objectWillChange.send()
    }

    private func move(from source: IndexSet, to destination: Int) {
        //        self.cityList.cities.move(fromOffsets: source, toOffset: destination)
        //        if isEditing == false {
        //            self.cityList.objectWillChange.send()
        //        }
        // Make an array of items from fetched results
        var revisedCities: [ UserCity ] = userCities.map{ $0 }

        // change the order of the items in the array
        revisedCities.move(fromOffsets: source, toOffset: destination )

        // update the userOrder attribute in revisedItems to
        // persist the new order. This is done in reverse order
        // to minimize changes to the indices.
        for reverseIndex in stride( from: revisedCities.count - 1,
                                    through: 0,
                                    by: -1 )
        {
            revisedCities[ reverseIndex ].order =
                Int16( reverseIndex )
        }
        saveObjectContext()
    }

    func saveObjectContext() {
        do {
            try managedObjectContext.save()
        } catch {
            print("Could not delete city")
        }
    }

}
