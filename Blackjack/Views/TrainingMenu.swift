//
//  TrainingMenu.swift
//  Blackjack
//
//  Created by Nikolas Collina on 11/15/20.
//

import SwiftUI

struct TrainingMenu: View {
    @EnvironmentObject var practiceModel : PracticeModel
    @State var isShowingPreference = false
    
    var body: some View {
        ZStack{
            Background()
            
            VStack{
                Spacer()
                Text("Training Mode")
                    .font(.headline)
                    .scaleEffect(2)
                Spacer()
                NavigationLink(destination: LearnBlackjack()){
                    
                    MenuButton(ButtonText: "Learn Blackjack")
                    
                }.padding()
                NavigationLink(destination: StrategyTable()){
                    
                    MenuButton(ButtonText: "Strategy Table")
                    
                }.padding()
                NavigationLink(destination: PracticeView()){
                    
                    MenuButton(ButtonText: "Practice")
                    
                }.padding()
                Spacer()
                HStack{
                    Spacer()
                    Button(action: { self.isShowingPreference.toggle() }){
                        Image(systemName: "gear").padding().foregroundColor(.gray)
                    }.sheet(isPresented: $isShowingPreference) {
                        Preferences(isShowingPreferences: self.$isShowingPreference)
                    }
                }
            }
        }
        
    }
}

struct TrainingMenu_Previews: PreviewProvider {
    static var previews: some View {
        TrainingMenu()
    }
}
