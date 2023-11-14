//
//  PhotoCellView.swift
//  Anima
//
//  Created by Muhammad M. Munir on 13/11/23.
//

import Combine
import Kingfisher
import SwiftUI

struct PhotoCellView: View {
    var name: String
    var imageURL: String
    var isLiked: Bool = false
    var showFavoriteButton: Bool = true
    var showName: Bool = false
    var onAction: () -> Void = {}
    
    @State private var publisher = PassthroughSubject<Bool, Never>()
    private let debounceInSeconds = 0.5
    
    var body: some View {
        Button(action: onAction, label: {
            ZStack(alignment: .topTrailing) {
                buildImageView()
                    
                if showFavoriteButton {
                    buildFavoriteButton()
                }
            }
            .overlay(alignment: .bottom) {
                if showName {
                    buildNameView()
                }
            }
        })
        .buttonStyle(.plain)
    }
    
    @ViewBuilder
    private func buildImageView() -> some View {
        KFImage.url(URL(string: imageURL))
            .resizable()
            .scaledToFit()
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.jade.opacity(0.1))
            }
    }
    
    @ViewBuilder
    private func buildFavoriteButton() -> some View {
        Image(systemName: isLiked ? "heart.fill" : "heart")
            .font(.system(size: 16, weight: .semibold))
            .foregroundStyle(Color.red)
            .padding(4)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.jade.opacity(0.4))
            }
            .padding(8)
    }
    
    @ViewBuilder
    private func buildNameView() -> some View {
        Text(name)
            .font(.textLight(size: 14))
            .foregroundStyle(Color.white)
            .frame(maxWidth: .infinity)
            .padding(4)
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.jade.opacity(0.7))
            }
    }
}

#Preview {
    PhotoCellView(
        name: "Lion",
        imageURL: "https://images.pexels.com/photos/41315/africa-african-animal-cat-41315.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
        isLiked: false,
        showFavoriteButton: true,
        showName: true
    )
    .frame(width: 200, height: 400)
}
