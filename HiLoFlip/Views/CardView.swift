//
//  CardView.swift
//  HiLoFlip
//
//  Created by Joel Ward on 10/29/24.
//

import Foundation
import SwiftUI

struct CardView: View {
    let card: HiLoGame.Card
    
    let cardAspectRatio = 2/3.0
    let centerCircleRatio = 2/3.0
    let bigCircleText = 0.3
    let smallCircleText = 0.15
    let HiLoCircleRatio = 0.7
    let cornerCircleRatio = 0.25
    let symbolRatio = 0.3
    @State var cardWidth = 10.0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                cardBackground
                card.isFaceUp ? AnyView(front) : AnyView(back)
            }
            .onAppear {
                cardWidth = geometry.size.width
            }
            .onChange(of: geometry.size.width) { oldWidth, newWidth in
                cardWidth = newWidth
            }
        }
        .aspectRatio(cardAspectRatio, contentMode: .fit)
        .padding(5)
    }
    
    @ViewBuilder
    var cardBackground: some View {
        RoundedRectangle(cornerRadius: 15.0)
            .fill(card.isFaceUp ? colorForIndex(card.value) : .black)
        }
    
    var front: some View {
        ZStack {
            centerCircle
            if card.value % 10 < 3 {
                cornerSymbols
            }
            
        }
    }
    
    var back: some View {
        VStack{
            HStack{
                HI
                Spacer()
            }
            Spacer()
            HStack{
                Spacer()
                LO
            }
        }
    }
    
    var HI: some View {
        ZStack{
            Circle()
                .stroke(.white)
                .padding(cardWidth / 10)
                .frame(width: HiLoCircleRatio * cardWidth, height: HiLoCircleRatio * cardWidth)
            Text("HI")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.white)
        }
    }

    var LO: some View {
        ZStack{
            Circle()
                .stroke(.white)
                .padding(cardWidth / 10)
                .frame(width: HiLoCircleRatio * cardWidth, height: HiLoCircleRatio * cardWidth)
            Text("LO")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.white)
        }
    }
    
    var centerCircle: some View {
        ZStack{
            Circle()
                .frame(width: cardWidth * centerCircleRatio, height: cardWidth * centerCircleRatio)
                .foregroundStyle(.black)
            Text(String(card.value))
                .font(.system(size: bigCircleText * cardWidth))
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .underline(underlinedNums.contains(card.value))
        }
    }

    var symbol: some View {
        ZStack{
            Circle()
                .foregroundStyle(.white)
                .frame(width: cardWidth * cornerCircleRatio, height: cardWidth * cornerCircleRatio)
            getSymbol(mod: card.value % 10)
                .frame(width: cardWidth * symbolRatio, height: cardWidth * symbolRatio)
        }
        .padding(5)
    }
    
    var cornerSymbols: some View {
        VStack {
            HStack{
                symbol
                Spacer()
            }
            Spacer()
            HStack{
                Spacer()
                symbol
                    .rotationEffect(Angle(degrees: 180))
            }
        }
    }
}
