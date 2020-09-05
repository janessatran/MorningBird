//
//  DetailButtons.swift
//  MorningBird
//
//  Created by Janessa Tran on 7/18/20.
//  Copyright © 2020 Janessa Tran. All rights reserved.
//

import SwiftUI

struct DetailButtons: View {
    let title: String
    let temp: String

    var body: some View {
        ZStack(alignment: .bottom) {
            BackgroundGradient()
            VStack {
                Text(title)
                    .font(.caption)
                    .padding(.top)
                Text(temp)
                    .font(.callout)
                    .padding(.bottom)
            }
            .frame(width: 100, height: 175)
                .foregroundColor(.white)
                .cornerRadius(32)
        }
    }
}

struct DetailButtons_Previews: PreviewProvider {
    static var previews: some View {
        DetailButtons(title: "Feels Like", temp: "23")
    }
}
