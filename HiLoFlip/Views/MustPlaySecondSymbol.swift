//
//  MustPlaySecondSymbol.swift
//  HiLoFlip
//
//  Created by Joel Ward on 10/24/24.
//

import Foundation
import SwiftUI

struct MustPlaySecondShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let height = Double(min(rect.width, rect.height) / 2)
        let cornerRadii = height/10
        
        let backCard = CGRect(x: rect.midX/1.75, y: rect.midY/2.2, width: height * (2/3) , height: height)
        
        let frontCard = CGRect(x: rect.midX/1.75 + (height/7), y: rect.midY/2.2 + (height/7), width: height * (2/3) , height: height)
        
        let cutout = CGRect(x: rect.midX/1.75 + (height/12), y: rect.midY/2.2 + (height/12), width: height * (2/3), height: height)
        
        var negative = Path()
        
        negative.addRoundedRect(in: cutout, cornerRadii: RectangleCornerRadii(topLeading: cornerRadii, bottomLeading: cornerRadii, bottomTrailing: cornerRadii, topTrailing: cornerRadii))
        
        path.addRoundedRect(in: backCard, cornerRadii: RectangleCornerRadii(topLeading: cornerRadii, bottomLeading: cornerRadii, bottomTrailing: cornerRadii, topTrailing: cornerRadii))
        
        path = path.subtracting(negative)
        
        path.addRoundedRect(in: frontCard, cornerRadii: RectangleCornerRadii(topLeading: cornerRadii, bottomLeading: cornerRadii, bottomTrailing: cornerRadii, topTrailing: cornerRadii))
        
        return path
    }
}

struct MustPlaySecondSymbol: View {
    var color: Color
    
    var body: some View {
        GeometryReader { geometry in
            MustPlaySecondShape()
                .foregroundStyle(color)
        }
        .aspectRatio(contentMode: .fit)
    }
}

#Preview {
    MustPlaySecondSymbol(color: .black)
}
