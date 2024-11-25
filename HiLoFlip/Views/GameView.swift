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
                .onTapGesture {
                    game.flipCoin()
                }
            if (game.topDiscardCard != nil) {
                CardView(card: game.topDiscardCard!, isUp: true)
                    .frame(width: 100, height: 150)
                    .overlay(discardPileFrameTracker)
            } else {
                RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                    .frame(width: 100, height: 150)
                    .overlay(discardPileFrameTracker)
            }
            CardView(card:Card(value: 0), isUp: false)
                .frame(width: 100, height: 150)
                .onTapGesture {
                    game.playerDraw()
                }
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
    
    var discardPileFrameTracker: some View {
        GeometryReader { geometry in
            Color.clear
                .onAppear {
                    self.discardPileFrame = geometry.frame(in: .global)
                }
                .onChange(of: geometry.frame(in: .global)) { _, newFrame in
                    self.discardPileFrame = newFrame
                }
        }
        .overlay(
            Rectangle()
                .strokeBorder(Color.red, lineWidth: draggedCard != nil ? 3 : 0)
                .opacity(0.3)
        )
    }
    
    func Hand(index: Int, isUp: Bool) -> some View {
        var Hand: some View {
            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], content: {
                    ForEach(game.players[index].hand, id: \.self.value) { card in
                        CardView(card: card, isUp: isUp)
                            .zIndex(draggedCard == card ? 1 : 0)
                            .offset(draggedCard == card ? dragOffset : .zero)
                            .gesture(dragGesture(for: card))
                    }.id(draggedCard)
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
        if discardPileFrame.contains(location) {
            withAnimation {
                game.playCard(card)
            }
        }
    }
}
