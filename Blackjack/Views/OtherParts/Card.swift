//
//  Card.swift
//  Blackjack
//
//  Created by Nikolas Collina on 11/11/20.
//

import SwiftUI

struct Card: View {
    let suit : String
    let value : String!
    let height : CGFloat
    @EnvironmentObject var playingModel : PlayingModel
    @Binding var flipped : Bool
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: GeneralConstants.cornerRadius)
                .foregroundColor(.white)
                .shadow(radius: 5)
            VStack{
                Image(suit).resizable()
                    .frame(width: height/25, height: height/25)
                Text(value)

            }.foregroundColor((suit == "Heart" || suit == "Diamond") ? .red : .black)
            .opacity(flipped ? 0.0 : 1.0)
            Image("cardBack").resizable()
                .opacity(flipped ? 1.0 : 0.0).animation(.easeOut(duration: 0.5))
        }
        .frame(width: height/14, height: height/7)
        .cornerRadius(10)
        .rotation3DEffect(self.flipped ? Angle(degrees: 180): Angle(degrees: 0), axis: (0,1,0))
        .animation(.easeOut(duration: 1.0))
    }
}

struct Card_Previews: PreviewProvider {
    @State static var flipped = true
    static var previews: some View {
        Card(suit: "Heart", value: "9", height: 100, flipped: $flipped)
    }
}
