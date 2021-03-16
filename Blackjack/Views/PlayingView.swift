//
//  PlayingView.swift
//  Blackjack
//
//  Created by Nikolas Collina on 11/9/20.
//

import SwiftUI

struct PlayingView: View {
    @EnvironmentObject var playingModel : PlayingModel
    @Environment(\.managedObjectContext) private var viewContext
    var bet = 5
    @State var isShowingPreference = false

    
    var body: some View {
        GeometryReader { fullScreen in
            ZStack{
                Background()
                
                VStack{
                    HStack{
                        Text("Balance: \(playingModel.balance)").padding(EdgeInsets( top: 20, leading: 0, bottom: 0, trailing: 10))
                    }.frame(height: fullScreen.size.height/11)
                    
                    Spacer()
                    
                    if playingModel.gameState != .betting {
                        DealerHand(height: fullScreen.size.height, hand: $playingModel.dealerHand)
                    }
                    
                    PlayingButtons().opacity((playingModel.gameState == .userHand1 || playingModel.gameState == .userHand2) ? 1.0 : 0.0)
                    

                    
                    if playingModel.gameState != .betting {
                        
                        
                        PlayerHand(height: fullScreen.size.height, hand: $playingModel.playerHand)
                            .scaleEffect(playingModel.gameState == .userHand1 ? 1.1 : 1)
                            .padding()
                        
                        if playingModel.playerHand2.count > 0 {
                            PlayerHand(height: fullScreen.size.height, hand: $playingModel.playerHand2)
                                .scaleEffect(playingModel.gameState == .userHand2 ? 1.1 : 1)
                        }
                        
                    }
                    Spacer()
                    
                    if playingModel.gameState == .betting {
                    
                    DealButton()
                    
                    
                        ChipRow().opacity(playingModel.gameState == .betting ? 1.0 : 0.0).padding(.bottom)
                    }
                    
                    else {
                        NextHandButton().padding()
                    
                    }
                }
                
                if playingModel.balance <= 0 {
                    LostButton()
                }
                
            }.navigationBarItems(trailing: SettingsButton)
        }.edgesIgnoringSafeArea(.all)
        
    }
    
    var SettingsButton : some View {
        Button(action: { self.isShowingPreference.toggle() }){
            Image(systemName: "gear").padding().foregroundColor(.gray)
        }.sheet(isPresented: $isShowingPreference) {
            Preferences(isShowingPreferences: self.$isShowingPreference)
        }
    }
}



struct PlayingView_Previews: PreviewProvider {
    static var previews: some View {
        PlayingView()
    }
}
