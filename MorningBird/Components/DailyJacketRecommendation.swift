//
//  DailyJacketRecommendation.swift
//  MorningBird
//
//  Created by Janessa Tran on 9/6/20.
//  Copyright © 2020 Janessa Tran. All rights reserved.
//

import SwiftUI

struct DailyJacketRecommendation: View {
    var icon: String { return "jumper" }

    var body: some View {
        ZStack(alignment: .top) {
            BackgroundGradient()
            VStack(alignment: .center) {
                Text("Personalized Jacket Recommendation")
                    .fontWeight(.bold)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                Image(icon)
                    .multilineTextAlignment(.center)
                Spacer().frame(height: 20)
                Text("Recommendation will go here...")
                    .font(.body)
                    .multilineTextAlignment(.center)
            }
            .padding(25)
            .frame(minWidth: 100, maxWidth: .infinity, minHeight: 200, maxHeight: .infinity)
        }
        .padding(25)
        .frame(maxHeight: 400)
    }
}

struct DailyJacketRecommendation_Previews: PreviewProvider {
    static var previews: some View {
        DailyJacketRecommendation()
    }
}
