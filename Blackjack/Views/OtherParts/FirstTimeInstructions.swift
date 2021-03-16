//
//  FirstTimeInstructions.swift
//  Blackjack
//
//  Created by Nikolas Collina on 12/12/20.
//

import SwiftUI

struct FirstTimeInstructions: View {
    @EnvironmentObject var playingModel : PlayingModel
    var body: some View {
        GeometryReader { full in
            ZStack {
                Background()
                ScrollView{
                    VStack{
                        Text("Blackjack App Instructions").scaleEffect(1.5).padding()
                        ForEach(Directions.text.indices) { id in
                            InstructionCard(index: id+1, cardText: Directions.text[id])
                                .foregroundColor(.white)
                                .frame(width: full.size.width*0.9)
                                .padding()
                        }
                        
                        Button(action: {playingModel.firstTime = false}){
                            ActionButton(action: "Dismiss")
                        }.padding()
                    }
                }
            }
        }.navigationBarHidden(true)
    }
}

struct FirstTimeInstructions_Previews: PreviewProvider {
    static var previews: some View {
        FirstTimeInstructions()
    }
}
