//
//  PracticeHand.swift
//  Blackjack
//
//  Created by Nikolas Collina on 11/15/20.
//

import Foundation

struct PracticeHand {
    var card1 : String
    var card2 : String
    var dealerCard : String
    var move : String
    var percentCorrect : Double
    var timesAttempted : Double
    var timesCorrect : Double
    var id = UUID()
}

extension PracticeHand : Codable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        card1 = try values.decode(String.self, forKey: .card1)
        card2 = try values.decode(String.self, forKey: .card2)
        dealerCard = try values.decode(String.self, forKey: .dealerCard)
        move = try values.decode(String.self, forKey: .move)
        percentCorrect = try values.decodeIfPresent(Double.self, forKey: .percentCorrect) ?? 0.51
        timesAttempted = try values.decodeIfPresent(Double.self, forKey: .timesAttempted) ?? 0
        timesCorrect = try values.decodeIfPresent(Double.self, forKey: .timesCorrect) ?? 0
    }
}
