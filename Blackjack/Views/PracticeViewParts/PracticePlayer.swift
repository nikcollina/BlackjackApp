//
//  PracticePlayer.swift
//  Blackjack
//
//  Created by Nikolas Collina on 11/20/20.
//

import SwiftUI

struct PracticePlayer: View {
    @EnvironmentObject var practiceModel : PracticeModel
    @State var flipped = false
    let height : CGFloat
    var body: some View {
        if practiceModel.hand >= 0 {
        HStack{
            Card(suit: practiceModel.handSuits[0], value: practiceModel.practiceHands[practiceModel.hand].card1, height: height*1.5, flipped: $practiceModel.flipped[0])
            Card(suit: practiceModel.handSuits[2], value: practiceModel.practiceHands[practiceModel.hand].card2, height: height*1.5, flipped: $practiceModel.flipped[2])
        }
        }
    }
}

struct PracticePlayer_Previews: PreviewProvider {
    static var previews: some View {
        PracticePlayer(height: 100)
    }
}
