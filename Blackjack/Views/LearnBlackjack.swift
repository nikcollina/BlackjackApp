//
//  LearnBlackjack.swift
//  Blackjack
//
//  Created by Nikolas Collina on 12/10/20.
//

import SwiftUI

struct LearnBlackjack: View {
    var body: some View {
        GeometryReader { screen in
            ZStack {
                Background()
                VStack{
                    Text("Rules of Blackjack")
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(){
                            ForEach(PracticeConstants.rules.indices, id:\.self) { id in
                                GeometryReader { cardGeometry in
                                    LearnCard(cardText: PracticeConstants.rules[id], index: id+1)
                                        .padding()
                                        .rotation3DEffect(
                                            .degrees( -Double(cardGeometry.frame(in: .global).midX - screen.frame(in: .global).midX)/20 ),
                                            axis: (x: 0, y: 1, z: 0))
                                        .opacity( 1 - abs(Double(cardGeometry.frame(in: .global).midX - screen.frame(in: .global).midX)/Double((screen.frame(in: .global).width/2))) )
                                }.frame(width: screen.size.width*0.75, height: screen.size.height*0.75)
                            }
                        }.padding(.leading, 5)
                        .padding(.vertical, 50)
                    }
                }
            }
        }
    }
}

struct LearnBlackjack_Previews: PreviewProvider {
    static var previews: some View {
        LearnBlackjack()
    }
}
