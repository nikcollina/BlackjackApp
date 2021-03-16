//
//  PracticeDealer.swift
//  Blackjack
//
//  Created by Nikolas Collina on 11/20/20.
//

import SwiftUI

struct PracticeDealer: View {
    @EnvironmentObject var practiceModel : PracticeModel
    //@State var flipped = false
    @State var notFlipped = true
    let height : CGFloat
    var body: some View {
        VStack {
            HStack{
                if practiceModel.hand >= 0{
                    Card(suit: practiceModel.handSuits[1], value: practiceModel.practiceHands[practiceModel.hand].dealerCard, height: height*1.5, flipped: $practiceModel.flipped[1])
                Card(suit: practiceModel.handSuits[0], value: "A", height: height*1.5, flipped: $notFlipped)
                }
            }
            
        }
    }
}

struct PracticeDealer_Previews: PreviewProvider {
    static var previews: some View {
        PracticeDealer(height: 100)
    }
}
