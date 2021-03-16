//
//  Chip.swift
//  Blackjack
//
//  Created by Nikolas Collina on 11/12/20.
//

import SwiftUI

struct Chip: View {
    let value : Int
    @EnvironmentObject var playingModel : PlayingModel
    var body: some View {
        Button(action: {playingModel.increaseBet(value: value)}){
            ZStack{
                Circle().frame(width: GeneralConstants.chipSize, height: GeneralConstants.chipSize).foregroundColor(Color.chipColor(for: value))
                Circle().strokeBorder(style: StrokeStyle(lineWidth: 4, dash: [14]), antialiased: true)
                    .frame(width:GeneralConstants.chipSize, height:GeneralConstants.chipSize)
                    .foregroundColor(value == 100 ? .white : .black)
                    .shadow(radius: 5)
                Text("\(value)").font(.subheadline).foregroundColor(value == 100 ? .white : .black)
            }
        }
    }
}

struct Chip_Previews: PreviewProvider {
    static var previews: some View {
        Chip(value: 5)
    }
}
