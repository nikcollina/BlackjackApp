//
//  ChipRow.swift
//  Blackjack
//
//  Created by Nikolas Collina on 11/17/20.
//

import SwiftUI

struct ChipRow: View {
    @EnvironmentObject var playingModel : PlayingModel
    var body: some View {
        VStack{
            HStack{
                Chip(value: 5)
                Chip(value: 10)
                Chip(value: 25)
                Chip(value: 50)
                Chip(value: 100)
                Button(action: {playingModel.bet = 0}){
                    ActionButton(action: "Reset")
                }
            }.padding()
            Text("Bet : \(playingModel.bet)")
        }
    }
}

struct ChipRow_Previews: PreviewProvider {
    static var previews: some View {
        ChipRow()
    }
}
