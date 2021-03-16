//
//  Color+Chip.swift
//  Blackjack
//
//  Created by Nikolas Collina on 11/12/20.
//  adapted from code in Memory app form class

import Foundation
import SwiftUI

enum backgroundColor : String, CaseIterable {
    case Red,Green,Blue
}

extension Color {
    static func chipColor(for amount: Int) -> Color {
        switch amount {
            case 5:
                return .red
            case 10:
                return .white
            case 25:
                return .green
            case 50:
                return .blue
            case 100:
                return .black
        default:
            return .yellow
        }
    }
}
