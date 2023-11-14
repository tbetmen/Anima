//
//  DetailScreenViewModel.swift
//  Anima
//
//  Created by Muhammad M. Munir on 13/11/23.
//

import Foundation
import Combine

final class DetailScreenViewModel: ObservableObject {
    @Published public var photos = [AnimalPhoto]()
    private var favorites = [LocalAnimalPhoto]()
    
    private var cancellables = Set<AnyCancellable>()
    
    private let photoService: PhotosServiceInterface
    private let favoriteService: FavoriteServiceInterface
    public let name: String
    
    init(
        photoService: PhotosServiceInterface = PhotosService(),
        favoriteService: FavoriteServiceInterface,
        name: String
    ) {
        self.photoService = photoService
        self.favoriteService = favoriteService
        self.name = name
    }
    
    public func loadData() {
        loadFavorites { [weak self] favorites in
            self?.loadPhotos(favorites)
        }
    }
    
    public func toggleFavorite(at index: Int) {
        photos[index].isLiked.toggle()
        
        let photo = photos[index]
        if photo.isLiked {
            self.favoriteService.saveFavorite(photo)
        } else {
            self.favoriteService.removeFavorite(photo)
        }
    }
    
    private func loadFavorites(_ onFinished: @escaping ([LocalAnimalPhoto]) -> Void) {
        favoriteService
            .getFavorites(animals: [])
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Failed to fetch favorites: \(error)")
                }
            } receiveValue: { favorites in
                onFinished(favorites)
            }
            .store(in: &cancellables)
    }
    
    private func loadPhotos(_ favorites: [LocalAnimalPhoto]) {
        photoService.fetchPhotos(name: name) { [weak self] result in
            switch result {
            case .success(let photos):
                self?.photos = photos.map { photo in
                    photo.update(isLiked: favorites.contains { $0.id == photo.id })
                }
            case .failure:()
            }
        }
    }
}
