//
//  ContentView.swift
//  HiLoFlip
//
//  Created by Joel Ward on 9/11/24.
//

import SwiftUI

var CardOrder = Array(1...100).shuffled()[0..<7]

func colorForIndex(_ index: Int) -> Color {
    let hue = Double(index) / 100.0
    return Color(hue: hue, saturation: 0.8, brightness: 1)
}


func getSymbol(i : Int) -> String {
    if i == 0 {
        return "star.fill"
    }
    else if i == 1 {
        return "circle.slash"
    }
    else {
        return "doc.on.doc.fill"
    }
}


var HI: some View {
    HStack{
        ZStack{
            Circle()
                .stroke(.white)
                .padding(10)
                .frame(width: 70, height: 70)
            Text("HI")
                .font(.title)
                .fontWeight(.medium)
                .foregroundStyle(.white)
        }
        Spacer()
    }
}


var LO: some View {
    HStack{
        Spacer()
        ZStack{
            Circle()
                .stroke(.white)
                .padding(10)
                .frame(width: 70, height: 70)
            Text("LO")
                .font(.title)
                .fontWeight(.medium)
                .foregroundStyle(.white)
        }
    }
}


var HiLoToken: some View {
    ZStack{
        Circle()
            .frame(width: 150, height: 150)
            .foregroundStyle(.black)
            .overlay(Circle().stroke(Color.white, lineWidth: 2).frame(width: 130, height: 130))
        Text("LO")
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundStyle(.white)
    }.padding()
}


struct CornerSymbols: View {
    var i: Int
    var body: some View {
        VStack {
            HStack{
                Symbol(i: i)
                Spacer()
            }
            Spacer()
            HStack{
                Spacer()
                Symbol(i: i)
            }
        }
    }
}


struct Symbol: View {
    var i: Int
    var body: some View {
        ZStack{
            Circle()
                .foregroundStyle(.white)
                .frame(width: 25, height: 25)
            Image(systemName: getSymbol(i: i % 10))
                .foregroundStyle(.black)
        }
        .padding(5)
    }
}


struct CenterCircle: View {
    var i: Int
    var body: some View {
        Circle()
            .frame(width: 70, height: 70)
        Text(String(i))
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundStyle(.white)    }
}


var ShuffleButton: some View {
    Button(action: {
        CardOrder = Array(1...100).shuffled()[0..<7]
            }) {
                Text("Shuffle")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
}

var HandView: some View {
    ScrollView{
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], content: {
            ForEach(CardOrder, id: \.self) { item in
                CardView(i: item)
            }
        }).padding()
    }
}

struct CardView: View {
    var i: Int
    @State var up: Bool = true
    var body: some View {
        ZStack{
            if !up {
                RoundedRectangle(cornerRadius: 15.0)
                    .fill(.black)
                VStack{
                    HI
                    LO
                }
            }
            else {
                RoundedRectangle(cornerRadius: 15.0)
                    .fill(colorForIndex(i))
                CenterCircle(i: i)
                if i % 10 < 3 {
                    CornerSymbols(i: i)
                }
            }
        }.frame(width: 100, height: 155)
            .onTapGesture {
                up = !up
            }
    }
}



struct GameView: View {
    var body: some View {
        ZStack{
            // hex: #007700
            Color(red: 0, green: (119/255), blue: 0).ignoresSafeArea()
            VStack {
                HStack{
                    Spacer()
                    HiLoToken
                    ShuffleButton
                    Spacer()
                }
                HandView
            }
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
