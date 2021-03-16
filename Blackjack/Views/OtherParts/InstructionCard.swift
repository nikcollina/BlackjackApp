//
//  InstructionCard.swift
//  Blackjack
//
//  Created by Nikolas Collina on 12/12/20.
//

import SwiftUI

struct InstructionCard: View {
    let index : Int
    let cardText : String
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: GeneralConstants.cornerRadius).foregroundColor(.black)
                .opacity(0.8)
            VStack {
                Text(cardText).padding()
                Text("\(index)/\(Directions.text.count)")
            }.padding()
        }
    }
}

struct InstructionCard_Previews: PreviewProvider {
    static var previews: some View {
        InstructionCard(index: 1, cardText: "Test")
    }
}
