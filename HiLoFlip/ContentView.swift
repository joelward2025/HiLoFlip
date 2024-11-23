//
//  ContentView.swift
//  HiLoFlip
//
//  Created by Joel Ward on 9/11/24.
//

import SwiftUI

let underlinedNums = [6, 9, 66, 99, 68, 86, 89, 98, 60, 90, 69, 96]

func colorForIndex(_ index: Int) -> Color {
    let hue = Double(index) / 100.0
    return Color(hue: hue, saturation: 0.8, brightness: 1)
}

@ViewBuilder
func getSymbol(mod : Int) -> some View {
    if mod == 0 {
        TenPointSymbol(color: .black)
    }
    else if mod == 1 {
        SkipSymbol(color: .black)
    }
    else {
        MustPlaySecondSymbol(color: .black)
    }
}

struct ContentView: View {
    @Environment(HiLoFlipCardGame.self) var gameManager

    var body: some View {
        NavigationStack{
            VStack {
                NavigationLink("Settings") {
                    SettingsView()
                }
                NavigationLink("Instructions") {
                    
                }
                NavigationLink("New Game") {
                    GameView()
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(HiLoFlipCardGame(playerNames: ["Player 1", "Player 2"]))
}
