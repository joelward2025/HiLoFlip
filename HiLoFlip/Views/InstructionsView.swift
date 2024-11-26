//
//  InstructionsView.swift
//  HiLoFlip
//
//  Created by Joel Ward on 11/25/24.
//

import Foundation
import SwiftUI

struct InstructionsView: View {
    var body: some View {
        VStack{
            Text("Instructions")
                .foregroundStyle(.blue)
                .font(.title)
                .bold()
            Spacer()
            Text("Taking your turn")
                .font(.headline)
                .bold()
            Text("        On your turn, drag and drop a playable card to the discard pile. If the token reads \"HI\", play a card higher than the top card in the discard pile. If the token reads \"LO\", play a card lower than the top card in the discard pile. If the pile is empty, play any card.")
            Text("        If you cannot play, tap the token to flip it. If you still cannot play, tap the draw pile to draw a card. If you still cannot play, you forfeit your turn. Your opponent then collects the entire discard pile.")
            Spacer()
            Text("\"Must Play 2\" Cards")
                .font(.headline)
                .bold()
            Text("        If you play a card ending in 2, you must immediately play a second card. If you cannot, your opponent colelcts the discard pile.")
            Spacer()
            Text("Skip Cards")
                .font(.headline)
                .bold()
            Text("        When a skip card is played, the opposing player must draw one card and loses their turn.")
            Spacer()
            Text("Ending the Game and Scoring")
                .font(.headline)
                .bold()
            Text("        The game ends when a player's hand is depleted. Cards ending in 0 are worth 10 points, while all other cards are worth 1.")
            Spacer()
        }
        .padding()
    }
}
