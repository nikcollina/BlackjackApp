//
//  DealButton.swift
//  Blackjack
//
//  Created by Nikolas Collina on 11/20/20.
//

import SwiftUI

struct DealButton: View {
    @EnvironmentObject var playingModel : PlayingModel
    var body: some View {
        Button(action: { withAnimation(.easeIn){playingModel.deal()} }) {
            ActionButton(action: "Deal")
        }.opacity(playingModel.gameState == .betting ? 1.0 : 0.0)
        .disabled(playingModel.gameState != .betting)
    }
}

struct DealButton_Previews: PreviewProvider {
    @State static var flipped = true
    static var previews: some View {
        DealButton()
    }
}
