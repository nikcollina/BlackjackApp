//
//  PracticeModel.swift
//  Blackjack
//
//  Created by Nikolas Collina on 11/15/20.
//

import Foundation

enum PossibleHands : String, CaseIterable {
    case All, Worst, Soft, Doubles
}

enum Result {
    case inProgress
    case Correct
    case Incorrect
}

typealias PracticeHands = [PracticeHand]

class PracticeModel: ObservableObject {
    @Published var practiceHands : PracticeHands
    
    @Published var possibleHands : PossibleHands = .All
    
    @Published var result : Result = .inProgress
        
    let suits = ["Heart", "Diamond", "Club", "Spade"]
    
    @Published var flipped = [true, true, true]
        
    let destinationURL : URL
    
    var hands = [Int]()
        
    @Published var hand = 0
    
    var handSuits = ["", "", ""]
    
    @Published var percentCorrect = 0.50
    
    init() {
        let filename = "Strategy"
        let mainBundle = Bundle.main
        let bundleURL = mainBundle.url(forResource: filename, withExtension: "json")!

        let fileManager = FileManager.default
        let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        destinationURL = documentURL.appendingPathComponent(filename + ".json")
        let fileExists = fileManager.fileExists(atPath: destinationURL.path)

        do {
            let url = fileExists ? destinationURL : bundleURL
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            practiceHands = try decoder.decode(PracticeHands.self, from: data)

        }
        catch {
            print("Error info: \(error)")
            practiceHands = []
        }
    }
    
    func saveData() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(practiceHands)
            try data.write(to: self.destinationURL)
        } catch {
            print("Error writing: \(error)")
        }
    }
    
    func shuffleSuits(){
        handSuits[0] = suits[Int.random(in: 0..<suits.count)]
        handSuits[1] = suits[Int.random(in: 0..<suits.count)]
        handSuits[2] = suits[Int.random(in: 0..<suits.count)]
    }
    
    func randomHand() {
        filterIndices()
        if hands.count > 0 {
            hand = hands[Int.random(in: 0..<hands.count)]
        
        }
        else {
             hand = -1
        }
    }
    
    func getValue(card : String) -> Int {
        if Int(card) != nil {
            return ((Int(card) ?? 0) - 1 )
        }
        else{
            switch card {
            case "A":
                return 0
            case "J":
                return 10
            case "Q":
                return 11
            case "K":
                return 12
            default:
                return 0
            }
        }
    }
    
    func checkAnswer(guess: String, answer: String) {
        if guess == answer {
            result = .Correct
            correct()
        }
        else {
            result = .Incorrect
            incorrect()
        }
    }
    
    func filterIndices() {
        var filteredHands = [PracticeHand]()
        switch possibleHands {
        case .All:
            filteredHands = practiceHands
        case .Worst:
            filteredHands = practiceHands.filter({$0.percentCorrect < percentCorrect})
        case .Soft:
            filteredHands = practiceHands.filter({$0.card1 == "A" || $0.card2 == "A"})
        case .Doubles:
            filteredHands = practiceHands.filter({$0.card1 == $0.card2})
        }
        let indicies = filteredHands.map{c in practiceHands.firstIndex(where: {$0.id == c.id})!}
        hands = indicies
    }
    
    func correct(){
        practiceHands[hand].timesCorrect += 1
        practiceHands[hand].timesAttempted += 1
        practiceHands[hand].percentCorrect = practiceHands[hand].timesCorrect / practiceHands[hand].timesAttempted
    }
    func incorrect(){
        practiceHands[hand].timesAttempted += 1
        practiceHands[hand].percentCorrect = practiceHands[hand].timesCorrect / practiceHands[hand].timesAttempted
    }
    
    
    func resetProgress() {
        for id in 0..<practiceHands.count {
            practiceHands[id].percentCorrect = 0.51
            practiceHands[id].timesCorrect = 0
            practiceHands[id].timesAttempted = 0
        }
        
    }
    
    func newHand(){
        flipped = [true, true, true]
        filterIndices()
        randomHand()
        shuffleSuits()
        result = .inProgress
        Timer.scheduledTimer(withTimeInterval: (PracticeConstants.flipTime), repeats: false) { _ in
            self.flipCards()
        }
    }
    
    func flipCards() {
        Timer.scheduledTimer(withTimeInterval: (PracticeConstants.flipTime), repeats: false) { _ in
            self.flipped[0] = false
        }
        Timer.scheduledTimer(withTimeInterval: (PracticeConstants.flipTime*2), repeats: false) { _ in
            self.flipped[1] = false
        }
        Timer.scheduledTimer(withTimeInterval: (PracticeConstants.flipTime*3), repeats: false) { _ in
            self.flipped[2] = false
        }
    }
    
}
