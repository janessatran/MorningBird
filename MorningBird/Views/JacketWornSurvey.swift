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

    var body: some View {
        ScrollView(.vertical) {
            JacketSurveyCard(city: city)
                .environment(\.managedObjectContext, self.managedObjectContext)
                .frame(maxHeight: 400)
            Spacer()
            DailyJacketRecommendation()
                .environment(\.managedObjectContext, self.managedObjectContext)
        }
    }


}
