//
//  MenuButton.swift
//  Blackjack
//
//  Created by Nikolas Collina on 11/17/20.
//

import SwiftUI

struct MenuButton: View {
    let ButtonText : String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: GeneralConstants.cornerRadius)
                .frame(width: 250, height: 75).foregroundColor(.white).opacity(0.8)
            Text(ButtonText).foregroundColor(.black)
        }
    }
}

struct MenuButton_Previews: PreviewProvider {
    static var previews: some View {
        MenuButton(ButtonText: "Test")
    }
}
