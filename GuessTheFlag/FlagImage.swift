//
//  FlagImage.swift
//  GuessTheFlag
//
//  Created by Steven Williams on 10/8/23.
//

import SwiftUI

struct FlagImage: View {
    var country: String
    var body: some View {
        Image(country)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

#Preview {
    FlagImage(country: "France")
}
