//
//  BackgroundGradient.swift
//  MorningBird
//
//  Created by Janessa Tran on 7/17/20.
//  Copyright © 2020 Janessa Tran. All rights reserved.
//

import Foundation
import SwiftUI

struct BackgroundGradient: View {
    var body: some View {
        Rectangle()
            .fill(LinearGradient(
                gradient: Gradient(colors: [ Palette.color1, Palette.color4 ]),
                startPoint: .top, endPoint: .bottom
            ))
            .edgesIgnoringSafeArea(.all)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#if DEBUG
struct BackgroundGradient_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundGradient()
    }
}
#endif
