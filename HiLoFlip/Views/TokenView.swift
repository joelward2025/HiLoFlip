//
//  TokenView.swift
//  HiLoFlip
//
//  Created by Joel Ward on 10/29/24.
//

import Foundation
import SwiftUI

struct TokenView: View {
    var isUp: Bool
    @State var press: Bool = false
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
        }
        .shadow(radius: press ? 20 : 0)
        .gesture(DragGesture(minimumDistance: 0.0, coordinateSpace: .global)
            .onChanged { _ in
                press = true
            }
            .onEnded { _ in
                press = false
            })
    }
}

#Preview {
    TokenView(isUp: true)
}
