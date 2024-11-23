//
//  HiLoFlipApp.swift
//  HiLoFlip
//
//  Created by Joel Ward on 9/11/24.
//

import SwiftUI

@main
struct HiLoFlipApp: App {
    @State var gameManager = HiLoFlipCardGame(playerNames: ["player1", "player2"])
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(gameManager)
        }
    }
}
