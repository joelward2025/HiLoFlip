//
//  GameView.swift
//  HiLoFlip
//
//  Created by Joel Ward on 10/29/24.
//

import Foundation
import SwiftUI

struct GameView: View {
    //var gameManager = HiLoFlipCardGame(playerNames: ["Player 1", "Player 2"])
    @Environment(HiLoFlipCardGame.self) var gameManager
    @Environment(\.dismiss) var dismiss

    typealias Card = HiLoGame.Card
    var isNewGame: Bool
    @State var draggedCard: Card?
    @State private var showActionSheet = false
    @GestureState var dragOffset: CGSize = .zero
    @State private var discardPileFrame: CGRect = .zero
    
    var body: some View {
        ZStack{
            Color(red: 0, green: (119/255), blue: 0).ignoresSafeArea()
            VStack {
                Text(gameManager.playerNames[0])
                    .foregroundStyle(.white)
                Hand(index: 0, isUp: gameManager.currPlayer == 0)
                    //.zIndex(1)
                midBar
                    //.zIndex(0)
                Hand(index: 1, isUp: gameManager.currPlayer == 1)
                    //.zIndex(0)
                Text(gameManager.playerNames[1])
                    .foregroundStyle(.white)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            Button("Quit") {
                showActionSheet = true
            }
            .actionSheet(isPresented: $showActionSheet) {
                ActionSheet(
                    title: Text("Are you sure?"),
                    buttons: [
                        .default(Text("Quit")) {
                            dismiss()
                        }
                    ]
                )
            }
        }
        .onAppear {
            if isNewGame {
                gameManager.resetGame()
            }
        }
    }
    
    var midBar: some View {
        HStack{
            Spacer()
            TokenView(isUp: gameManager.isTokenHi)
                .onTapGesture {
                    gameManager.flipCoin()
                }
            if (gameManager.topDiscardCard != nil) {
                CardView(card: gameManager.topDiscardCard!, isUp: true)
                    .frame(width: 100, height: 150)
                    .overlay(discardPileFrameTracker)
            } else {
                ZStack{
                    RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                        .frame(width: 100, height: 150)
                        .foregroundStyle(.black)
                        .overlay(discardPileFrameTracker)
                    Text("Discard")
                        .foregroundStyle(.white)
                        .font(.body)
                }
            }
            CardView(card:Card(value: 0), isUp: false)
                .frame(width: 100, height: 150)
                .onTapGesture {
                    gameManager.playerDraw()
                }
            Spacer()
        }
    }
    
    var shuffleButton: some View {
        Button(action: {
            gameManager.resetGame()}) {
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
            ScrollView(.horizontal){
                LazyHGrid(rows: [GridItem(.adaptive(minimum: 100))]) {
                    ForEach(gameManager.players[index].hand, id: \.self.value) { card in
                        CardView(card: card, isUp: isUp)
                            .zIndex(draggedCard == card ? 1 : 0)
                            .offset(draggedCard == card ? dragOffset : .zero)
                            .gesture(dragGesture(for: card))
                            .shadow(color: draggedCard == card ? .black : .clear, radius: 10)
                    }.id(draggedCard)
                }
            }.layoutPriority(1)
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
                gameManager.playCard(card)
            }
        }
    }
}
