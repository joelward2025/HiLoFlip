//
//  GameView.swift
//  HiLoFlip
//
//  Created by Joel Ward on 10/29/24.
//

import Foundation
import SwiftUI

struct GameView: View {
    var game = HiLoFlipCardGame(playerNames: ["Player 1", "Player 2"])
    
    typealias Card = HiLoGame.Card
    @State var draggedCard: Card?
    @GestureState var dragOffset: CGSize = .zero
    @State private var discardPileFrame: CGRect = .zero
    
    var body: some View {
        ZStack{
            Color(red: 0, green: (119/255), blue: 0).ignoresSafeArea()
            VStack {
                Hand(index: 0, isUp: game.currPlayer == 0)
                midBar
                Hand(index: 1, isUp: game.currPlayer == 1)
            }
        }
    }
    
    var midBar: some View {
        HStack{
            Spacer()
            TokenView(isUp: game.isTokenHi)
            shuffleButton
            Spacer()
        }
    }
    
    var shuffleButton: some View {
        Button(action: {
            game.resetGame()}) {
                    Text("Shuffle")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
    }
    
    
    func Hand(index: Int, isUp: Bool) -> some View {
        var Hand: some View {
            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], content: {
                    ForEach(game.players[index].hand, id: \.self.value) { item in
                        CardView(card: item, isUp: isUp)
                            .gesture(dragGesture(for: item))
                    }
                })
            }
        }
        return Hand
    }
    
    func dragGesture(for card: Card) -> some Gesture {
        DragGesture(coordinateSpace: .global)
            .onChanged { value in
                if draggedCard == nil {
                    draggedCard = card
                }
                if discardPileFrame.contains(value.location) {
                    
                }
            }
            .updating($dragOffset) { value, dragOffset, _  in
                dragOffset = value.translation
            }
            .onEnded { value in
                handleDrop(for: card, at: value.location)
                draggedCard = nil
            }
    }
    
    func handleDrop(for card: Card, at location: CGPoint) {
        print("Drop handling...")
        print("Discard Pile Frame:", discardPileFrame)
        print("Drop Location:", location)
        
        //if discardPileFrame.contains(location) {
            // If the card is dropped within the discard pile's area, make a play
            withAnimation {
                game.playCard(card)
            }
        //}
    }
}
