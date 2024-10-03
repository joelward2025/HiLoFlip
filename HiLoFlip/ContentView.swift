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

func getSymbol(mod : Int) -> String {
    if mod == 0 {
        return "star.fill"
    }
    else if mod == 1 {
        return "circle.slash"
    }
    else {
        return "doc.on.doc.fill"
    }
}

struct TokenView: View {
    var isUp: Bool
    var body: some View {
        ZStack{
            Circle()
                .frame(width: 150, height: 150)
                .foregroundStyle(.black)
                .overlay(Circle().stroke(Color.white, lineWidth: 2).frame(width: 130, height: 130))
            Text(isUp ? "HI" : "LO")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.white)
        }.padding()
    }
}

struct CardView: View {
    let card: HiLoGame.Card
    let cardAspectRatio = 2/3.0
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 15.0)
                .fill(card.isFaceUp ? colorForIndex(card.value) : .black)
            card.isFaceUp ? AnyView(Front) : AnyView(Back)
        }.frame(width: 80, height: 125)
         .padding(5)
    }
    
    var Front: some View {
        ZStack {
            CenterCircle
            if card.value % 10 < 3 {
                CornerSymbols
            }
            
        }
    }
    
    var Back: some View {
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
                .padding(10)
                .frame(width: 70, height: 70)
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
                .padding(10)
                .frame(width: 70, height: 70)
            Text("LO")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.white)
        }
    }
    
    var CenterCircle: some View {
        ZStack{
            Circle()
                .frame(width: 56, height: 56)
                .foregroundStyle(.black)
            Text(String(card.value))
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .underline(underlinedNums.contains(card.value))
        }
    }

    var Symbol: some View {
        ZStack{
            Circle()
                .foregroundStyle(.white)
                .frame(width: 25, height: 25)
            Image(systemName: getSymbol(mod: card.value % 10))
                .foregroundStyle(.black)
        }
        .padding(5)
    }
    
    var CornerSymbols: some View {
        VStack {
            HStack{
                Symbol
                Spacer()
            }
            Spacer()
            HStack{
                Spacer()
                Symbol
            }
        }
    }
}


struct GameView: View {
    var game = HiLoFlipCardGame(playerNames: ["Player 1", "Player 2"])
    
    var body: some View {
        ZStack{
            Color(red: 0, green: (119/255), blue: 0).ignoresSafeArea()
            VStack {
                Hand(index: 0)
                MidBar
                Hand(index: 1)
            }
        }
    }
    
    var MidBar: some View {
        HStack{
            Spacer()
            TokenView(isUp: game.isTokenHi)
            ShuffleButton
            Spacer()
        }
    }
    
    var ShuffleButton: some View {
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
    
    
    func Hand(index: Int) -> some View {
        var Hand: some View {
            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 84))], content: {
                    ForEach(game.players[index].hand, id: \.self.value) { item in
                        CardView(card: item)
                    }
                })
            }
        }
        
        return Hand
    }
}

struct ContentView: View {
    var body: some View {
        GameView()
    }
}

#Preview {
    ContentView()
}
