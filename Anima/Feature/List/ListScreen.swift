//
//  ListScreen.swift
//  Anima
//
//  Created by Muhammad M. Munir on 13/11/23.
//

import SwiftUI

struct ListScreen: View {
    @Environment(\.managedObjectContext) var context
    @StateObject var viewModel = ListScreenViewModel()
    
    var body: some View {
        buildContentView()
            .task {
                viewModel.loadAnimals()
            }
    }
    
    @ViewBuilder
    private func buildContentView() -> some View {
        VStack {
            buildHeaderView()
            
            if viewModel.isLoading {
                buildShimmerCellView()
            } else {
                List(
                    Array(viewModel.animals.enumerated()),
                    id: \.element.id
                ) { index, item in
                    buildAnimalCellView(index, item)
                }
                .listStyle(.plain)
                .padding(.horizontal, 8)
            }
        }
        .padding(16)
        .ignoresSafeArea(.container, edges: .bottom)
    }
    
    @ViewBuilder
    private func buildHeaderView() -> some View {
        HStack(spacing: 8) {
            Text("Anima 🐾")
                .font(.textBlack(size: 32))
                .foregroundStyle(Color.jade)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            NavigationLink(destination: {
                FavoriteScreen(context: context)
            }, label: {
                Image(systemName: "heart")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundStyle(Color.white)
                    .padding(8)
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.jade)
                    }
            })
        }
    }
    
    @ViewBuilder
    private func buildAnimalCellView(_ index: Int, _ animal: Animal) -> some View {
        let background = [
            Color.jade,
            Color.pweter,
            Color.cerulean,
            Color.gullGray,
        ][index % 4]
        
        VStack(spacing: 0) {
            HStack {
                Text(animal.nameFormatted)
                    .font(.textHeavy(size: 24))
                    .foregroundStyle(Color.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack(spacing: 8) {
                    Text(animal.isExpanded ? "Hide Types" : "Show Types")
                        .font(.textLight(size: 12))
                        .foregroundStyle(Color.black)
                        .padding(8)
                        .background {
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundStyle(Color.white)
                        }
                        .onTapGesture {
                            viewModel.animals[index].isExpanded.toggle()
                        }

                    NavigationLink(destination: {
                        DetailScreen(
                            context: context,
                            name: animal.name
                        )
                    }, label: {
                        EmptyView()
                    })
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: 0)
                    .opacity(0)
                }
            }
            .padding(16)
            
            if animal.isExpanded {
                Text("**Types**: \(animal.typesFormatted)")
                    .font(.textLight(size: 14))
                    .foregroundStyle(Color.black)
                    .padding(16)
                    .background {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(background.opacity(0.4))
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
            }
        }
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(background.opacity(0.4))
        }
        .listRowInsets(EdgeInsets())
        .listRowSeparator(.hidden)
        .padding(.bottom, 16)
    }
    
    @ViewBuilder
    private func buildShimmerCellView() -> some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(0..<6) { _ in
                    ShimmerView()
                        .frame(height: 70)
                }
            }
        }
        .padding(8)
    }
}

#Preview {
    ListScreen()
}
