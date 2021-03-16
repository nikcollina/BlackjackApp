//
//  PlayingState.swift
//  Blackjack
//
//  Created by Nikolas Collina on 12/6/20.
//

import Foundation

struct PlayingState {
    var balance : Int //1000
    var background : String
    var firstTime : Bool
    var highestBalance : Int
}

extension PlayingState : Codable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        balance = try values.decodeIfPresent(Int.self, forKey: .balance) ?? 1000
        background = try values.decodeIfPresent(String.self, forKey: .background) ?? "Green"
        firstTime = try values.decodeIfPresent(Bool.self, forKey: .firstTime) ?? true
        highestBalance = try values.decodeIfPresent(Int.self, forKey: .highestBalance) ?? 0
    }
}


