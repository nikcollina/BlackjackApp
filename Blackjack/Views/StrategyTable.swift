//
//  StrategyTable.swift
//  Blackjack
//
//  Created by Nikolas Collina on 12/13/20.
//

import SwiftUI

struct StrategyTable: View {
    var body: some View {
        GeometryReader { fullScreen in
            ZStack{
                Background()
                ScrollView {
                    VStack {
                        Text("Strategy Table").scaleEffect(2).padding()
                        Image("StrategyTable").resizable()
                            .scaledToFit()
                            .frame(width: fullScreen.size.width*0.9, alignment: .center)
                    }
                }
                
            }
        }
    }
}

struct StrategyTable_Previews: PreviewProvider {
    static var previews: some View {
        StrategyTable()
    }
}
