//
//  PlayingModel.swift
//  Blackjack
//
//  Created by Nikolas Collina on 11/10/20.
//

import Foundation

enum GameState: String {
    case betting, userHand1, userHand2, dealerMove, endHand
}

struct CardData {
    var flipped : Bool = true
    let value : Int = Int.random(in: PlayingConstants.cardMin..<PlayingConstants.cardMax)
}


class PlayingModel : ObservableObject{
    @Published var dealerHand = [CardData]()
    @Published var playerHand = [CardData]()
    @Published var playerHand2 = [CardData]()
    @Published var balance = 1000
    @Published var bet = 5
    @Published var gameState : GameState = .betting
    var playingState : PlayingState
    @Published var background : backgroundColor = .Green
    @Published var firstTime = true
    var highestBalance = 0
    
    let destinationURL : URL
    
    init() {
        let filename = "PlayingData"
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
            playingState = try decoder.decode(PlayingState.self, from: data)
            balance = playingState.balance
            background = backgroundColor(rawValue: playingState.background) ?? .Green
            firstTime = playingState.firstTime
            highestBalance = playingState.highestBalance
            
        }
        catch {
            print("Error info: \(error)")
            playingState = PlayingState(balance: 1000, background: "Green", firstTime: true, highestBalance: 0)
            
        }
    }
    
    func saveData() {
        playingState.balance = balance
        playingState.background = background.rawValue
        playingState.firstTime = firstTime
        playingState.highestBalance = highestBalance
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(playingState)
            try data.write(to: self.destinationURL)
        } catch {
            print("Error writing: \(error)")
        }
    }
    
    func getCardValue(card : CardData) -> Int {
        let cardVal = (card.value % PlayingConstants.cardsPerSuit) + 1
        if  cardVal > PlayingConstants.faceCardValue {
            return PlayingConstants.faceCardValue
        }
        else if cardVal == 1 {
            return PlayingConstants.aceValue
        }
        else {
            return cardVal
        }
    }
    
    func getTextValue(value : Int) -> String {
        let cardVal = (value % PlayingConstants.cardsPerSuit) + 1
        if (cardVal > PlayingConstants.faceCardValue || cardVal == PlayingConstants.aceNumber) {
            switch cardVal {
            case PlayingConstants.jackNumber:
                return "J"
            case PlayingConstants.queenNumber:
                return "Q"
            case PlayingConstants.kingNumber:
                return "K"
            case PlayingConstants.aceNumber:
                return "A"
            default:
                return "Error"
            }
        }
        else {
            return "\(cardVal)"
        }
    }
    
    
    func getSuit(card : CardData) -> String {
        let suit = (card.value-1) / PlayingConstants.cardsPerSuit
        switch suit {
        case PlayingConstants.heart:
            return "Heart"
        case PlayingConstants.diamond:
            return "Diamond"
        case PlayingConstants.club:
            return "Club"
        case PlayingConstants.spade:
            return "Spade"
        default:
            return "Error"
        }
    }
    
    func deal(){
        dealerHand = [CardData(), CardData()]
        playerHand = [CardData(), CardData()]
        playerHand2 = []
        gameState = .userHand1
        Timer.scheduledTimer(withTimeInterval: PlayingConstants.flipTime, repeats: false) { _ in
            self.dealFlip()
        }
        if checkBlackjack(hand: playerHand){
            balance += Int(Double(bet) * PlayingConstants.blackjackMultiplier)
            Timer.scheduledTimer(withTimeInterval: PlayingConstants.flipTime*5, repeats: false) { _ in
                self.dealerHand[1].flipped = false
            }
            gameState = .endHand
        }
        if checkBlackjack(hand: dealerHand){
            balance -= bet
            Timer.scheduledTimer(withTimeInterval: PlayingConstants.flipTime*5, repeats: false) { _ in
                self.dealerHand[1].flipped = false
            }
            gameState = .endHand
        }
        
    }
    
    func dealFlip(){
        Timer.scheduledTimer(withTimeInterval: PlayingConstants.flipTime, repeats: false) { _ in
            self.playerHand[0].flipped = false
        }
        Timer.scheduledTimer(withTimeInterval: PlayingConstants.flipTime*2, repeats: false) { _ in
            self.dealerHand[0].flipped = false
        }
        Timer.scheduledTimer(withTimeInterval: PlayingConstants.flipTime*3, repeats: false) { _ in
            self.playerHand[1].flipped = false
        }
        
        
    }
    
    func reset(){
        if balance > highestBalance {
            highestBalance = balance
        }
        gameState = .betting
    }
    
    func hit() {
        if gameState == .userHand1 {
            playerHand.append(CardData())
            Timer.scheduledTimer(withTimeInterval: PlayingConstants.flipTime, repeats: false) { _ in
                self.playerHand[self.playerHand.count-1].flipped = false
            }
            if checkHand(values: playerHand) == PlayingConstants.maxTotal {
                stand()
            }
            else if checkHand(values: playerHand) > PlayingConstants.maxTotal {
                balance -= bet
                if playerHand2.count > 0 {
                    gameState = .userHand2
                }
                else {
                    gameState = .endHand
                    Timer.scheduledTimer(withTimeInterval: PlayingConstants.flipTime*2, repeats: false) { _ in
                        self.dealerHand[1].flipped = false
                    }
                }
            }
        }
        else {
            playerHand2.append(CardData())
            Timer.scheduledTimer(withTimeInterval: PlayingConstants.flipTime, repeats: false) { _ in
                self.playerHand2[self.playerHand2.count-1].flipped = false
            }
            if checkHand(values: playerHand2) == PlayingConstants.maxTotal {
                dealerTurn()
            }
            else if checkHand(values: playerHand2) > PlayingConstants.maxTotal {
                balance -= bet
                gameState = .endHand
            }
        }
    }
    
    func doubleDown() {
        playerHand.append(CardData())
        Timer.scheduledTimer(withTimeInterval: PlayingConstants.flipTime, repeats: false) { _ in
            self.playerHand[self.playerHand.count-1].flipped = false
        }
        
        bet *= PlayingConstants.doubleDownMultiplier
        
        if checkHand(values: playerHand) > PlayingConstants.maxTotal {
            balance -= bet
            gameState = .endHand
        }
        
        else {
            dealerTurn()
        }
        
        bet /= PlayingConstants.doubleDownMultiplier
        
    }
    
    func stand() {
        if gameState == .userHand1 {
            if playerHand2.count > 0 {
                gameState = .userHand2
                return
            }
        }
        dealerTurn()
    }
    
    func split() {
        let tempCard = playerHand[1]
        playerHand.remove(at: 1)
        self.playerHand2.append(tempCard)
        self.playerHand.append(CardData())
        self.playerHand2.append(CardData())
        self.playerHand[1].flipped = false
        Timer.scheduledTimer(withTimeInterval: PlayingConstants.flipTime, repeats: false) { _ in
            self.playerHand2[1].flipped = false
        }
    }
    
    func checkHand(values : [CardData]) -> Int {
        var total : Int = 0
        for value in values {
            
            let cardVal = getCardValue(card: value)
            total += cardVal
        }
        if total > PlayingConstants.maxTotal {
            total = 0
            for value in values {
                
                let cardVal = getCardValue(card: value)
                if cardVal == PlayingConstants.aceValue {
                    total += 1
                }
                else {
                    total += cardVal
                }
            }
        }
        return total
    }
    
    
    
    func dealerTurn()  {
        gameState = .dealerMove
        var dealerCardQueue : [CardData] = []
        while checkHand(values: (dealerHand + dealerCardQueue)) < PlayingConstants.dealerStay {
            dealerCardQueue.append(CardData())
        }
        
        for (index,card) in dealerCardQueue.enumerated() {
            
            Timer.scheduledTimer(withTimeInterval: (PlayingConstants.flipTime*Double(index)), repeats: false) { _ in
                self.dealerHand.append(card)
                self.dealerHand[index+1].flipped = false
                
            }
        }
        
        Timer.scheduledTimer(withTimeInterval: Double(dealerCardQueue.count) * PlayingConstants.flipTime, repeats: false) { _ in
            self.dealerHand[self.dealerHand.count - 1].flipped = false
            
            
            if self.checkHand(values: self.dealerHand) > PlayingConstants.maxTotal {
                self.balance += self.bet
                
            }
            else {
                if self.checkHand(values: self.playerHand) > self.checkHand(values: self.dealerHand) {
                    self.balance += self.bet
                    
                }
                else if self.checkHand(values: self.playerHand) == self.checkHand(values: self.dealerHand) {
                    
                }
                else {
                    self.balance -= self.bet
                    
                }
            }
            self.gameState = .endHand
        }
        
        return
    }
    
    func checkBlackjack(hand : [CardData]) -> Bool {
        if checkHand(values: hand) == PlayingConstants.blackjack {
            return true
        }
        else {
            return false
        }
    }
    
    func increaseBet(value: Int) {
        bet += value
        if bet > balance {
            bet = balance
        }
    }
    
    
    
    // Button Availability Functions
    
    func canDoubleDown() -> Bool {
        return (playerHand.count == 2) && (playerHand2.count < 1)
    }
    
    func canHit() -> Bool {
        switch gameState {
        case .userHand1:
            if checkHand(values: playerHand) < PlayingConstants.maxTotal {
                return true
            }
        case .userHand2:
            if checkHand(values: playerHand2) < PlayingConstants.maxTotal {
                return true
            }
        default:
            return false
        }
        return false
    }
    
    func canStand() -> Bool {
        switch gameState {
        case .userHand1, .userHand2:
            return true
        default:
            return false
        }
    }
    
    func canSplit() -> Bool {
        switch gameState {
        case .userHand1:
            if (getCardValue(card: playerHand[0]) == getCardValue(card: playerHand[1])) {
                return true
            }
        default:
            return false
        }
        return false
    }
}
