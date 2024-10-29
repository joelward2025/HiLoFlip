//
//  HiLoFlipCardGame.swift
//  HiLoFlip
//
//  Created by Joel Ward on 9/30/24.
//

import Foundation 
import SwiftUI

@Observable class HiLoFlipCardGame {
    private var game: HiLoGame
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
}
