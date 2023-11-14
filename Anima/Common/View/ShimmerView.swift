//
//  ShimmerView.swift
//  Anima
//
//  Created by Muhammad M. Munir on 13/11/23.
//

import SwiftUI

struct ShimmerView: View {
    
    @State private var shimmering = false
    
    let streamSnow = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
    let streamGray = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color(streamSnow), Color(streamGray)]),
                       startPoint: .leading,
                       endPoint: shimmering ? .trailing : .leading)
        .mask(RoundedRectangle(cornerRadius: 10))
        .animation(.easeOut(duration: 1).repeatForever(autoreverses: false), value: shimmering)
        .onAppear {
            shimmering.toggle()
        }
    }
}

#Preview {
    ShimmerView()
}
