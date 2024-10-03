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
    private(set) var players: [HiLoGame.Player]
    private(set) var isTokenHi: Bool
    
    init(playerNames: [String]) {
        let tempGame = HiLoGame(players: playerNames)
        self.game = tempGame
        players = tempGame.players
        isTokenHi = tempGame.isTokenHi
    }
    
    func resetGame() {
        self.game.resetGame()
        players = game.players
        isTokenHi = game.isTokenHi
    }
    
    func hand(player: HiLoGame.Player) -> [HiLoGame.Card]{
        return player.hand
    }
}
