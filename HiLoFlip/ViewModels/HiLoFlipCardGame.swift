//
//  HiLoFlipCardGame.swift
//  HiLoFlip
//
//  Created by Joel Ward on 9/30/24.
//

import Foundation 
import SwiftUI

@Observable
class HiLoFlipCardGame {
    private var game: HiLoGame
    typealias Card = HiLoGame.Card
    
    var players: [HiLoGame.Player] {
        get {
            game.players
        }
    }
    var isTokenHi: Bool {
        get {
            self.game.isTokenHi
        }
    }
    
    var topDiscardCard: Card? {
        game.topDiscardCard
    }
    
    var currPlayer: Int {
        game.currPlayer
    }
    
    var playerNames: [String] {
        get {game.playerNames}
        set {game.playerNames = newValue}
    }
    
    init(playerNames: [String]) {
        let tempGame = HiLoGame(players: playerNames)
        self.game = tempGame
    }
    
    func resetGame() {
        self.game.resetGame()
    }
    
    func hand(player: HiLoGame.Player) -> [HiLoGame.Card]{
        return player.hand
    }
    
    func playCard(_ card: Card) {
        if let discardCard = topDiscardCard, card.canPlay(on: discardCard, hi: isTokenHi) {
            game.playCard(card)
        }
    }
}
