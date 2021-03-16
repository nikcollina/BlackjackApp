//
//  NextHandButton.swift
//  Blackjack
//
//  Created by Nikolas Collina on 11/20/20.
//

import SwiftUI

struct NextHandButton: View {
    @EnvironmentObject var playingModel : PlayingModel
    var body: some View {
        Button(action: {
            withAnimation(){
                playingModel.reset()
            }
            
        } )
        {
            ActionButton(action: "Next\nHand")
        }.opacity(playingModel.gameState == .endHand ? 1.0 : 0.0)
        .disabled(playingModel.gameState != .endHand || playingModel.balance <= 0)
    }
}

struct NextHandButton_Previews: PreviewProvider {
    static var previews: some View {
        NextHandButton()
    }
}
