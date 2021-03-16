//
//  LearnCard.swift
//  Blackjack
//
//  Created by Nikolas Collina on 12/10/20.
//

import SwiftUI

struct LearnCard: View {
    let cardText : String
    let index : Int
    var body: some View {
        
            ZStack{
                RoundedRectangle(cornerRadius: GeneralConstants.cornerRadius).foregroundColor(.black)
                VStack {
                Text(cardText).padding()
                    Text("\(index)/\(PracticeConstants.rules.count)")
                }.foregroundColor(.white)
            }
        }
    
}

struct LearnCard_Previews: PreviewProvider {
    static var previews: some View {
        LearnCard(cardText: "Test", index: 1)
    }
}
