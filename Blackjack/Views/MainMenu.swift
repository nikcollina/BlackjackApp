//
//  MainMenu.swift
//  Blackjack
//
//  Created by Nikolas Collina on 11/9/20.
//

import SwiftUI

struct MainMenu: View {
    @EnvironmentObject var playingModel : PlayingModel
    @State private  var isShowingPreference = false

    
    
    var body: some View {
        NavigationView{
            ZStack{
                Background()
                
                VStack{
                    Spacer()
                    Text("Blackjack")
                        .font(.headline)
                        .scaleEffect(2)
                    Spacer()
                    NavigationLink(destination: PlayingView()){
                        
                        MenuButton(ButtonText: "Play Blackjack")
                        
                    }.padding()
                    NavigationLink(destination: TrainingMenu()){

                        MenuButton(ButtonText: "Training Mode")
                        
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
                if playingModel.firstTime {
                    FirstTimeInstructions()
                    
                }
                
            }
            
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu()
    }
}
