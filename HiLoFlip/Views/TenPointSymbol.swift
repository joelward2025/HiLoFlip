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
        let outerRadius  = Double(min(rect.width, rect.height) / 3)
        let innerRadius  = rect.midX / 3.8
        

        path.move(to: CGPoint(x: mx + __cospi(0.1) * outerRadius, y: my - __sinpi(0.1) * outerRadius))
        path.addLine(to: CGPoint(x: mx + __cospi(0.3) * innerRadius, y: my - __sinpi(0.3) * innerRadius))
        path.addLine(to: CGPoint(x: mx + __cospi(0.5) * outerRadius, y: my - __sinpi(0.5) * outerRadius))
        path.addLine(to: CGPoint(x: mx + __cospi(0.7) * innerRadius, y: my - __sinpi(0.7) * innerRadius))
        path.addLine(to: CGPoint(x: mx + __cospi(0.9) * outerRadius, y: my - __sinpi(0.9) * outerRadius))
        path.addLine(to: CGPoint(x: mx + __cospi(1.1) * innerRadius, y: my - __sinpi(1.1) * innerRadius))
        path.addLine(to: CGPoint(x: mx + __cospi(1.3) * outerRadius, y: my - __sinpi(1.3) * outerRadius))
        path.addLine(to: CGPoint(x: mx + __cospi(1.5) * innerRadius, y: my - __sinpi(1.5) * innerRadius))
        path.addLine(to: CGPoint(x: mx + __cospi(1.7) * outerRadius, y: my - __sinpi(1.7) * outerRadius))
        path.addLine(to: CGPoint(x: mx + __cospi(1.9) * innerRadius, y: my - __sinpi(1.9) * innerRadius))
        path.addLine(to: CGPoint(x: mx + __cospi(0.1) * outerRadius, y: my - __sinpi(0.1) * outerRadius))
        
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
