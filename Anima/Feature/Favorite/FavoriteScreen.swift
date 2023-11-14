//
//  FavoriteScreen.swift
//  Anima
//
//  Created by Muhammad M. Munir on 13/11/23.
//

import CoreData
import SwiftUI

struct FavoriteScreen: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var viewModel: FavoriteScreenViewModel
    
    var body: some View {
        buildContentView()
            .task {
                viewModel.loadData()
            }
            .sheet(isPresented: $viewModel.isShowFilter, onDismiss: {
                viewModel.resetFilterTemp()
            }, content: {
                buildFilterView()
            })
    }
    
    init(context: NSManagedObjectContext) {
        _viewModel = StateObject(
            wrappedValue: FavoriteScreenViewModel(
                favoriteService: FavoriteService(context: context)
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
                    ForEach(viewModel.favorites) { favorite in
                        PhotoCellView(
                            name: favorite.name ?? "",
                            imageURL: favorite.imageURL ?? "",
                            showFavoriteButton: false,
                            showName: true
                        )
                    }
                }
            }
            .background {
                if viewModel.favorites.isEmpty {
                    BackgroundView(title: "Anima")
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
            
            Text("Favorites")
                .font(.textBlack(size: 32))
                .foregroundStyle(Color.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Button(action: {
                viewModel.applyFilterTemp()
                viewModel.isShowFilter = true
            }, label: {
                Image(systemName: "slider.horizontal.3")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundStyle(Color.white)
                    .padding(8)
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.jade)
                    }
            })
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    private func buildFilterView() -> some View {
        VStack {
            Text("Filter")
                .font(.textBlack(size: 32))
                .foregroundStyle(Color.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            List(
                Array(viewModel.animalTypeFilterTemp.enumerated()),
                id: \.element.id
            ) { index, animal in
                Button(action: {
                    viewModel.toggleChecked(index)
                }, label: {
                    HStack {
                        Image(systemName: animal.isChecked ? "checkmark.square" : "square")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundStyle(Color.jade)
                        Text(animal.name.formatted)
                            .font(.textBook(size: 16))
                            .foregroundStyle(Color.black)
                    }
                })
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            
            Button(action: {
                viewModel.applyFilter()
                viewModel.isShowFilter = false
            }, label: {
                Text("Apply")
                    .font(.textBook(size: 24))
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity)
                    .padding(8)
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.jade)
                    }
            })
        }
        .padding(16)
    }
}

#Preview {
    FavoriteScreen(
        context: CoreDataController.preview.container.viewContext
    )
}
