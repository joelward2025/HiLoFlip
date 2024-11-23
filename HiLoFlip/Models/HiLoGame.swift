//
//  HiLoGame.swift
//  HiLoFlip
//
//  Created by Joel Ward on 9/30/24.
//

import Foundation

struct HiLoGame {
    private(set) var deck: [Card]
    private(set) var discardPile: [Card]
    private(set) var players: [Player]
    private(set) var isTokenHi: Bool
    private(set) var currPlayer : Int
    
    init(players: [String]) {
        
        self.players = players.map {Player(name: $0)}
        self.deck = Array(1...100).map {Card(value: $0)}
        self.isTokenHi = Bool.random()
        self.discardPile = [Card(value: 50)]
        self.currPlayer = 0
        dealCards()
    }
    
    var playerNames: [String] {
        get { players.map { $0.name } }
        set {
            for index in 0..<newValue.count {
                players[index].name = newValue[index]
            }
        }
    }

    
    private mutating func dealCards() {
        self.deck = self.deck.shuffled()
        for p in 0...(players.count-1) {
            for i in 0...6 {
                players[p].hand.append(self.deck[(p*7) + i])
            }
        }
    }
    
    mutating func resetGame() {
        for p in 0...(players.count-1) {
            players[p].hand = []
        }
        self.deck = Array(1...100).map {Card(value: $0)}
        self.isTokenHi = Bool.random()
        dealCards()
    }
    
    struct Card {
        let value: Int
        fileprivate(set) var isFaceUp: Bool
        private(set) var isSpecialCard: Bool
        private(set) var isTenPointCard: Bool
        private(set) var isSkipCard: Bool
        private(set) var isMustPlaySecondCard: Bool
        
        init(value: Int) {
            self.value = value
            self.isTenPointCard = ((value % 10) == 0)
            self.isMustPlaySecondCard = ((value % 10) == 1)
            self.isSkipCard = ((value % 10) == 2)
            self.isSpecialCard = ((value % 10) < 3)
            self.isFaceUp = true
        }
        
        func canPlay(on topCard: Card, hi: Bool) -> Bool {
            if hi {
                return self.value > topCard.value
            }
            else {
                return self.value < topCard.value
            }
        }
    }
    
    struct Player {
        fileprivate(set) var name: String
        fileprivate(set) var hand: [Card]
        private(set) var score: Int
        
        init(name: String){
            self.name = name
            self.hand = []
            self.score = 0
        }
        
        mutating func playItem(_ card: Card) -> Card? {
            if let index = hand.firstIndex(where: { $0.value == card.value }) {
                return hand.remove(at: index)
            } else {
                return nil
            }
        }
    }
    
    var topDiscardCard: Card? {
        var card = discardPile.last
        card?.isFaceUp = true
        return card
    }
    
    mutating func playCard(_ card: Card) {
        if let topDiscardCard = discardPile.last,
           card.canPlay(on: topDiscardCard, hi: isTokenHi),
           let card = players[currPlayer].playItem(card) {
            discardPile.append(card)
        }
    }
}
