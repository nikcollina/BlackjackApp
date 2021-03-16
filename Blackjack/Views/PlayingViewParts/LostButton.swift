//
//  LostButton.swift
//  Blackjack
//
//  Created by Nikolas Collina on 12/11/20.
//

import SwiftUI

struct LostButton: View {
    @EnvironmentObject var playingModel : PlayingModel

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: GeneralConstants.cornerRadius)
            VStack {
                Text("Your balance has reached zero.").foregroundColor(.white)
                Button (action: {playingModel.balance = 1000
                    playingModel.bet = 5
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: GeneralConstants.cornerRadius)
                            .stroke(style: StrokeStyle())
                            .frame(width: 100, height: 50)
                        Text("Start Over")
                    }
                })
            }
        }
    }
}

struct LostButton_Previews: PreviewProvider {
    static var previews: some View {
        LostButton()
    }
}
