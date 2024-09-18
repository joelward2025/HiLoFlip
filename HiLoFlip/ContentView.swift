//
//  ContentView.swift
//  HiLoFlip
//
//  Created by Joel Ward on 9/11/24.
//

import SwiftUI

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
    var side: Bool
    var body: some View {
        ZStack{
            Circle()
                .frame(width: 150, height: 150)
                .foregroundStyle(.black)
                .overlay(Circle().stroke(Color.white, lineWidth: 2).frame(width: 130, height: 130))
            Text(side ? "LO" : "HI")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.white)
        }.padding()
    }
}

struct CardView: View {
    var index: Int
    @State var up: Bool = true
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 15.0)
                .fill(up ? colorForIndex(index) : .black)
            up ? AnyView(Front) : AnyView(Back)
        }.frame(width: 100, height: 155)
         .onTapGesture {
             up = !up
         }.padding(5)
    }
    
    var Front: some View {
        ZStack {
            CenterCircle
            if index % 10 < 3 {
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
                .frame(width: 70, height: 70)
                .foregroundStyle(.black)
            Text(String(index))
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.white)
        }
    }
    
    var Symbol: some View {
        ZStack{
            Circle()
                .foregroundStyle(.white)
                .frame(width: 25, height: 25)
            Image(systemName: getSymbol(mod: index % 10))
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
    @State var CardOrder = Array(1...100).shuffled()[0..<7]
    @State var side = true
    
    var body: some View {
        ZStack{
            Color(red: 0, green: (119/255), blue: 0).ignoresSafeArea()
            VStack {
                TopBar
                Hand
            }
        }
    }
    
    var TopBar: some View {
        HStack{
            Spacer()
            TokenView(side: side)
            ShuffleButton
            Spacer()
        }
    }
    
    var ShuffleButton: some View {
        Button(action: {
            CardOrder = Array(1...100).shuffled()[0..<7]
            side = Bool.random()}) {
                    Text("Shuffle")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
    }
    
    var Hand: some View {
        ScrollView{
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], content: {
                ForEach(CardOrder, id: \.self) { item in
                    CardView(index: item)
                }
            }).padding()
        }
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
