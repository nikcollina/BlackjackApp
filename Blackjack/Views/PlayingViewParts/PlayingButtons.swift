//
//  PlayingButtons.swift
//  Blackjack
//
//  Created by Nikolas Collina on 11/17/20.
//

import SwiftUI

struct PlayingButtons: View {
    @EnvironmentObject var playingModel : PlayingModel
    var body: some View {
        HStack{
            
            // Double Down Button
            Button(action: { withAnimation(){ playingModel.doubleDown()} }) {
                ActionButton(action: "Double\nDown")
            }.disabled(!playingModel.canDoubleDown())
            .opacity(playingModel.canDoubleDown() ? 1 : 0.5)
            
            
            // Hit Button
            Button(action: { withAnimation(){ playingModel.hit()} }) {
                ActionButton(action: "Hit")
            }.disabled(!playingModel.canHit())
            .opacity(playingModel.canHit() ? 1 : 0.5)
            
            
            // Stand Button
            Button(action: { withAnimation(){ playingModel.stand()} }) {
                ActionButton(action: "Stand")
            }
            .disabled(!playingModel.canStand())
            .opacity(playingModel.canStand() ? 1 : 0.5)
            
            
            // Split Button
            Button(action: { withAnimation(){ playingModel.split()} }) {
                ActionButton(action: "Split")
            }.disabled(!playingModel.canSplit())
            .opacity(playingModel.canSplit() ? 1 : 0.5)
        }
    }
}

struct PlayingButtons_Previews: PreviewProvider {
    static var previews: some View {
        PlayingButtons()
    }
}
