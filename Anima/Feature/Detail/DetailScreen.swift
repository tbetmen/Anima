//
//  DetailScreen.swift
//  Anima
//
//  Created by Muhammad M. Munir on 13/11/23.
//

import CoreData
import SwiftUI

struct DetailScreen: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var viewModel: DetailScreenViewModel
    
    var body: some View {
        buildContentView()
            .task {
                viewModel.loadData()
            }
    }
    
    init(context: NSManagedObjectContext, name: String = "Lion") {
        _viewModel = StateObject(
            wrappedValue: DetailScreenViewModel(
                favoriteService: FavoriteService(context: context),
                name: name
            )
        )
    }
    
    @ViewBuilder
    private func buildContentView() -> some View {
        VStack {
            buildHeaderView()
            ScrollView([.vertical]) {
                LazyVGrid(
                    columns: [GridItem(spacing: 16), GridItem(spacing: 16), GridItem()],
                    spacing: 16
                ) {
                    buildPhotosView()
                }
            }
            .background {
                if viewModel.photos.isEmpty {
                    BackgroundView(title: "loading ...")
                }
            }
        }
        .padding(16)
        .ignoresSafeArea(.container, edges: .bottom)
        .navigationBarBackButtonHidden(true)
    }
    
    @ViewBuilder
    private func buildHeaderView() -> some View {
        HStack(spacing: 16) {
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "arrow.left")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundStyle(Color.white)
                    .padding(8)
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.jade)
                    }
            })
            
            Text(viewModel.name.capitalized)
                .font(.textBlack(size: 32))
                .foregroundStyle(Color.black)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    private func buildPhotosView() -> some View {
        ForEach(
            Array(viewModel.photos.enumerated()),
            id: \.element.id
        ) { index, photo in
            PhotoCellView(
                name: photo.name.formatted,
                imageURL: photo.imageURL,
                isLiked: photo.isLiked,
                onAction: {
                    viewModel.toggleFavorite(at: index)
                }
            )
        }
    }
}

#Preview {
    DetailScreen(
        context: CoreDataController.preview.container.viewContext
    )
}
