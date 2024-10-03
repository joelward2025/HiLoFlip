//
//  HiLoGame.swift
//  HiLoFlip
//
//  Created by Joel Ward on 9/30/24.
//

import Foundation

struct HiLoGame {
    private(set) var deck: [Card]
    private(set) var players: [Player]
    private(set) var isTokenHi: Bool
    
    init(players: [String]) {
        
        self.players = players.map {Player(name: $0)}
        self.deck = Array(1...100).map {Card(value: $0)}
        self.isTokenHi = Bool.random()
        //dealCards()
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
    }
    
    struct Player {
        private(set) var name: String
        fileprivate(set) var hand: [Card]
        private(set) var score: Int
        
        init(name: String){
            self.name = name
            self.hand = []
            self.score = 0
        }
    }
}
