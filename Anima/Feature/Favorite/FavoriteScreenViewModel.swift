//
//  FavoriteScreenViewModel.swift
//  Anima
//
//  Created by Muhammad M. Munir on 13/11/23.
//

import Combine
import Foundation

final class FavoriteScreenViewModel: ObservableObject {
    @Published public var favorites = [LocalAnimalPhoto]()
    @Published public var animalTypeFilter = [AnimalTypeFilter]()
    @Published public var animalTypeFilterTemp = [AnimalTypeFilter]()
    @Published public var isShowFilter = false
    
    private let favoriteService: FavoriteServiceInterface
    private var cancellables = Set<AnyCancellable>()
    
    init(favoriteService: FavoriteServiceInterface) {
        self.animalTypeFilter = AnimalTypeFilter.datas
        self.animalTypeFilterTemp = AnimalTypeFilter.datas
        self.favoriteService = favoriteService
    }
    
    public func loadData(animals: [AnimalType] = []) {
        favoriteService
            .getFavorites(animals: animals)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Failed to fetch favorites: \(error)")
                }
            } receiveValue: { [weak self] favorites in
                self?.favorites = favorites
            }
            .store(in: &cancellables)
    }
    
    public func toggleChecked(_ index: Int) {
        animalTypeFilterTemp[index].isChecked.toggle()
    }
    
    public func resetFilterTemp() {
        animalTypeFilterTemp = AnimalTypeFilter.datas
    }
    
    public func applyFilter() {
        animalTypeFilter = animalTypeFilterTemp
        loadData(animals: animalTypeFilter.animalTypes())
    }
    
    public func applyFilterTemp() {
        animalTypeFilterTemp = animalTypeFilter
    }
}
