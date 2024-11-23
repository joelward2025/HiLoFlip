//
//  SettingsView.swift
//  HiLoFlip
//
//  Created by Joel Ward on 11/22/24.
//


import Foundation
import SwiftUI

struct SettingsView: View {
    @Environment(HiLoFlipCardGame.self) var gameManager
        
    var body: some View {
        @Bindable var gameManager = gameManager
        Form {
            Section(header: Text("Player Names")) {
                ForEach(gameManager.playerNames.indices, id:\.self) { index in
                    TextField("Player \(index + 1)", text: $gameManager.playerNames[index])
                }
            }
        }
    }
}

#Preview {
    SettingsView()
        .environment(HiLoFlipCardGame(playerNames: ["Player 1", "Player 2"]))
}
