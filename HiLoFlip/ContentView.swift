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
                .stroke(.white).padding(10)
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
                .stroke(.white).padding(10)
                .frame(width: 70, height: 70)
            Text("LO")
                .font(.title)
                .fontWeight(.medium)
                .foregroundStyle(.white)
        }
    }
}

struct CardView: View {
    var i: Int
    @State var corner: String = ""
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
                VStack(spacing: 0){
                    if i % 10 < 3 {
                        HStack {
                            ZStack{
                                Circle()
                                    .foregroundStyle(.white)
                                    .frame(width: 25, height: 25)
                                
                                Image(systemName: getSymbol(i: i % 10))
                                    .foregroundStyle(.black)
                            }
                            .padding(.top, 5)
                            .padding(.leading, 5)
                            Spacer()
                        }
                    }
                    Spacer()
                    ZStack {
                        Circle()
                            .frame(width: 70, height: 70)
                        Text(String(i))
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                    }
                    Spacer()
                    if i % 10 < 3 {
                        HStack {
                            Spacer()
                            ZStack{
                                Circle()
                                    .foregroundStyle(.white)
                                    .frame(width: 25, height: 25)
                                
                                Image(systemName: getSymbol(i: i % 10))
                                    .foregroundStyle(.black)
                            }
                            .padding(.bottom, 5)
                            .padding(.trailing, 5)
                        }
                    }
                }
            }
        }.frame(width: 100, height: 155)
        .onTapGesture {
                    up = !up
                }
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            CardView(i: 60)
        }
    }
}

#Preview {
    ContentView()
}
