//
//  Preferences.swift
//  Blackjack
//
//  Created by Nikolas Collina on 12/11/20.
//

import SwiftUI

struct Preferences: View {
    @Binding var isShowingPreferences : Bool
    @EnvironmentObject var playingModel : PlayingModel
    @EnvironmentObject var practiceModel : PracticeModel
    var body: some View {
        NavigationView {
            ZStack {
                Form {
                    Section(header: Text("Show Directions")) {
                        Button(action: {playingModel.firstTime = true}, label: {
                            Text("Tap Here")
                        })
                    }
                    Section(header: Text("Background Color")) {
                        Picker("Color", selection: $playingModel.background){
                            ForEach(backgroundColor.allCases, id:\.self) { value in
                                Text("\(value.rawValue)")
                            }
                            
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                    Section(header: Text("Practice Hand Type")){
                        Picker("Type", selection: $practiceModel.possibleHands){
                            ForEach(PossibleHands.allCases, id:\.self) { value in
                                Text("\(value.rawValue)")
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                    Section(header: Text("Worst Hand Percentage")){
                        Text("Highest percent correct for a hand to appear when \"Worst\" is selected.")
                        Stepper(value: $practiceModel.percentCorrect, in: 0.2...0.7, step: 0.05) {
                            Text(String(format: "%.0f%", (practiceModel.percentCorrect * 100)))
                        }
                    }
                    Section(header: Text("")){
                        Button(action: {practiceModel.resetProgress()}, label: {
                            Text("Reset Practice Hand Data")
                        })
                    }
                    Section(header: Text("High Scores")) {
                        Text("Highest Playing Balance: \(playingModel.highestBalance)")
                    }
                    
                }
                if playingModel.firstTime {
                    FirstTimeInstructions()
                }
                
            }
        }
    }
}

struct Preferences_Previews: PreviewProvider {
    @State static var pref = true
    static var previews: some View {
        Preferences(isShowingPreferences: $pref)
    }
}

