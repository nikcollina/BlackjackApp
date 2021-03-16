//
//  Hand.swift
//  Blackjack
//
//  Created by Nikolas Collina on 12/10/20.
//

import SwiftUI

struct Hand: View {
    @EnvironmentObject var playingModel : PlayingModel
    @Binding var hand : [CardData]
    let height : CGFloat
    var body: some View {
        VStack{
            HStack{
                
                ForEach(hand.indices, id:\.self) { id in
                    
                    Card(suit: playingModel.getSuit(card: hand[id]), value: playingModel.getTextValue( value: hand[id].value), height: height, flipped: $hand[id].flipped)
                        .scaleEffect(hand.count > 4 ? 0.75 : 1)
                }
                
            }.animation(.easeInOut(duration: 1.0))
            
        }
    }
    
}

//struct Hand_Previews: PreviewProvider {
//    static var previews: some View {
//        Hand()
//    }
//}
