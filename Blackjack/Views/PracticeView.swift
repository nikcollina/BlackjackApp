//
//  PracticeView.swift
//  Blackjack
//
//  Created by Nikolas Collina on 11/15/20.
//

import SwiftUI

struct PracticeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var practiceModel : PracticeModel
    @State var isShowingPreference = false
    
    var body: some View {
        GeometryReader { fullScreen in
            ZStack{
                Background()
                if practiceModel.hand >= 0 {
                    VStack{
                        
                        PracticeDealer(height: fullScreen.size.height)
                        
                        Spacer()
                        
                        
                        PracticeResult()
                            .frame(width: fullScreen.size.width*0.9, alignment: .center)
                            .padding()
                        
                        
                        Spacer()
                        
                        
                        PracticeButtons()
                        
                        
                        PracticePlayer(height: fullScreen.size.height)
                        
                        
                        Button(action: {
                            practiceModel.newHand()
                        }) {
                            ActionButton(action: "Next\nHand")
                        }
                    }
                }
                else {
                    Text("No available hands for selected preferences.").multilineTextAlignment(.center)
                    
                }
            }
        }
        .navigationBarItems(trailing: SettingsButton)
        .onAppear(){
            practiceModel.newHand()
        }
        
        
        
    }
    var SettingsButton : some View {
        Button(action: { self.isShowingPreference.toggle() }){
            Image(systemName: "gear").padding().foregroundColor(.gray)
        }.sheet(isPresented: $isShowingPreference) {
            Preferences(isShowingPreferences: self.$isShowingPreference)
        }
    }
}

struct PracticeView_Previews: PreviewProvider {
    static var previews: some View {
        PracticeView()
    }
}
