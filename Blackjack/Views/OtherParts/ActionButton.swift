//
//  ActionButton.swift
//  Blackjack
//
//  Created by Nikolas Collina on 11/11/20.
//

import SwiftUI

struct ActionButton: View {
    let action : String
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.black).frame(width: 75, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 2).foregroundColor(.white)
                .frame(width: 75, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .shadow(radius: 5)
            Text(action)
                .foregroundColor(.white).multilineTextAlignment(.center)
        }
    }
}

struct ActionButton_Previews: PreviewProvider {
    static var previews: some View {
        ActionButton(action: "Double\nDown")
    }
}
