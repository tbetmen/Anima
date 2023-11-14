//
//  BackgroundView.swift
//  Anima
//
//  Created by Muhammad M. Munir on 13/11/23.
//

import SwiftUI

struct BackgroundView: View {
    var title: String
    
    var body: some View {
        VStack(spacing: 0) {
            Image("logo")
                .resizable()
                .frame(width: 200, height: 200)
                .foregroundStyle(Color.jade)
            
            Text(title)
                .font(.textHeavy(size: 30))
                .foregroundStyle(Color.jade)
        }
    }
}

#Preview {
    BackgroundView(title: "loading ...")
}
