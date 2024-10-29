//
//  TenPointSymbol.swift
//  HiLoFlip
//
//  Created by Joel Ward on 10/28/24.
//

import Foundation

import Foundation
import SwiftUI

struct TenPointShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let mx = rect.midX
        let my = rect.midY
        let r  = rect.midX
        let s  = rect.midX / 2.3
        

        path.move(to: CGPoint(x: mx + __cospi(0.1) * r, y: my - __sinpi(0.1) * r))
        path.addLine(to: CGPoint(x: mx + __cospi(0.3) * s, y: my - __sinpi(0.3) * s))
        path.addLine(to: CGPoint(x: mx + __cospi(0.5) * r, y: my - __sinpi(0.5) * r))
        path.addLine(to: CGPoint(x: mx + __cospi(0.7) * s, y: my - __sinpi(0.7) * s))
        path.addLine(to: CGPoint(x: mx + __cospi(0.9) * r, y: my - __sinpi(0.9) * r))
        path.addLine(to: CGPoint(x: mx + __cospi(1.1) * s, y: my - __sinpi(1.1) * s))
        path.addLine(to: CGPoint(x: mx + __cospi(1.3) * r, y: my - __sinpi(1.3) * r))
        path.addLine(to: CGPoint(x: mx + __cospi(1.5) * s, y: my - __sinpi(1.5) * s))
        path.addLine(to: CGPoint(x: mx + __cospi(1.7) * r, y: my - __sinpi(1.7) * r))
        path.addLine(to: CGPoint(x: mx + __cospi(1.9) * s, y: my - __sinpi(1.9) * s))
        path.addLine(to: CGPoint(x: mx + __cospi(0.1) * r, y: my - __sinpi(0.1) * r))
        
        return path

    }
}

struct TenPointSymbol: View {
    var color: Color
    
    var body: some View {
        GeometryReader { geometry in
            TenPointShape()
                .fill(color)
        }
        .aspectRatio(contentMode: .fit)
    }
}

#Preview {
    TenPointSymbol(color: .black)
}
