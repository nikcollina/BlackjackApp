//
//  PlayerHand.swift
//  Blackjack
//
//  Created by Nikolas Collina on 11/17/20.
//

import SwiftUI

struct PlayerHand: View {
    @EnvironmentObject var playingModel : PlayingModel
    let height : CGFloat
    @Binding var hand : [CardData]
    var body: some View {

        VStack{
            Hand(hand: $hand, height: height).opacity(playingModel.gameState == .betting ? 0.0 : 1.0)
            
            Text("\(playingModel.checkHand(values: hand))")
                .opacity((playingModel.gameState != .betting) ? 1.0 : 0.0)
        }
    }
}

//struct PlayerHand_Previews: PreviewProvider {
//    @State static var flipped = true
//    static var previews: some View {
//        PlayerHand(height: 100, hand: <#Binding<[CardData]>#>)
//    }
//}
