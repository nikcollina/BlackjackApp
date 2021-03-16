//
//  PracticeButtons.swift
//  Blackjack
//
//  Created by Nikolas Collina on 11/20/20.
//

import SwiftUI

struct PracticeButtons: View {
    @EnvironmentObject var practiceModel : PracticeModel
    var body: some View {
        if practiceModel.hand >= 0 {
        VStack {
            HStack{
                
                Button(action: {
                    practiceModel.checkAnswer(guess: "Double\nDown", answer: practiceModel.practiceHands[practiceModel.hand].move)
                }){
                    ActionButton(action: "Double\nDown")
                }.disabled(practiceModel.result != .inProgress)
                
                
                
                Button(action: {
                    practiceModel.checkAnswer(guess: "Hit", answer: practiceModel.practiceHands[practiceModel.hand].move)
                }){
                    ActionButton(action: "Hit")
                }.disabled(practiceModel.result != .inProgress)
                
                
                
                Button(action: {
                    practiceModel.checkAnswer(guess: "Stand", answer: practiceModel.practiceHands[practiceModel.hand].move)
                }){
                    ActionButton(action: "Stand")
                }.disabled(practiceModel.result != .inProgress)
                
                
                
                Button(action: {
                    practiceModel.checkAnswer(guess: "Split", answer: practiceModel.practiceHands[practiceModel.hand].move)
                }){
                    ActionButton(action: "Split")
                }.disabled(practiceModel.result != .inProgress)
                
            }
        }
        }
    }
}

struct PracticeButtons_Previews: PreviewProvider {
    @State static var answer = "Correct"
    static var previews: some View {
        PracticeButtons()
    }
}
