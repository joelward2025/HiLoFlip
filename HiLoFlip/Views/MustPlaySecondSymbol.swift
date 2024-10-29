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
        
        let width = rect.maxX - rect.minX
        let height = rect.maxY - rect.minY
        
        let backCard = CGRect(x: rect.minX, y: rect.minY, width: width * (2/3) , height: width )
        
        let frontCard = CGRect(x: rect.minX + (width/8), y: rect.minY + (width/8), width: width * (2/3) , height: width)
        
        let cutout = CGRect(x: rect.minX + (width/12), y: rect.minY + (width/12), width: width * (2/3) , height: width)
        
        var negative = Path()
        
        negative.addRoundedRect(in: cutout, cornerRadii: RectangleCornerRadii(topLeading: 25, bottomLeading: 25, bottomTrailing: 25, topTrailing: 25))
        
        path.addRoundedRect(in: backCard, cornerRadii: RectangleCornerRadii(topLeading: 25, bottomLeading: 25, bottomTrailing: 25, topTrailing: 25))
        
        path = path.subtracting(negative)
        
        path.addRoundedRect(in: frontCard, cornerRadii: RectangleCornerRadii(topLeading: 25, bottomLeading: 25, bottomTrailing: 25, topTrailing: 25))
        
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
        .padding()
    }
}

#Preview {
    MustPlaySecondSymbol(color: .black)
}
