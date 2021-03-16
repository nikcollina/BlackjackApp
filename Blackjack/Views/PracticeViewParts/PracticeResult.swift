//
//  PracticeResult.swift
//  Blackjack
//
//  Created by Nikolas Collina on 11/20/20.
//

import SwiftUI

struct PracticeResult: View {
    @EnvironmentObject var practiceModel : PracticeModel
    var body: some View {
        if practiceModel.hand >= 0 {
            ZStack {
                HStack {
                    RoundedRectangle(cornerRadius: GeneralConstants.cornerRadius)
                        .foregroundColor(.black)
                        .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                }
                Text(practiceModel.result == .Correct ? "That is the correct move for this situation." : """
            That is the incorrect move in this situation you should
            """ + " " + practiceModel.practiceHands[practiceModel.hand].move + ".").foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
            }
            
            .opacity(practiceModel.result == .inProgress ? 0.0 : 1.0)
        }
        
    }
}

struct PracticeResult_Previews: PreviewProvider {
    static var previews: some View {
        PracticeResult()
    }
}
