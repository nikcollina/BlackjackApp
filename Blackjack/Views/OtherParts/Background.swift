//
//  Background.swift
//  Blackjack
//
//  Created by Nikolas Collina on 12/11/20.
//

import SwiftUI

struct Background: View {
    @EnvironmentObject var playingModel : PlayingModel
    var body: some View {
        switch playingModel.background {
        case .Green:
            return Color.init(red: 13/180, green: 89/180, blue: 1/180).edgesIgnoringSafeArea(.all)
        case .Red:
            return Color.init(red: 101/180, green: 29/180, blue: 50/180).edgesIgnoringSafeArea(.all)
        case .Blue:
            return Color.init(red: 14/180, green: 77/180, blue: 146/180).edgesIgnoringSafeArea(.all)
        }
    }
}

struct Background_Previews: PreviewProvider {
    static var previews: some View {
        Background()
    }
}
