//
//  FavoriteService.swift
//  Anima
//
//  Created by Muhammad M. Munir on 13/11/23.
//

import Combine
import CoreData
import Foundation

protocol FavoriteServiceInterface {
    func getFavorites(
        animals animalTypes: [AnimalType]
    ) -> AnyPublisher<[LocalAnimalPhoto], Error>
    func saveFavorite(_ photo: AnimalPhoto)
    func removeFavorite(_ photo: AnimalPhoto)
}

final class FavoriteService {
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
}

extension FavoriteService: FavoriteServiceInterface {
    func getFavorites(
        animals animalTypes: [AnimalType] = []
    ) -> AnyPublisher<[LocalAnimalPhoto], Error> {
        let request = LocalAnimalPhoto.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "createdAt", ascending: true)
        ]
        if !animalTypes.isEmpty {
            let predicates = animalTypes.map {
                NSPredicate(format: "name = %@", $0.rawValue)
            }
            let compoundPredicate = NSCompoundPredicate(
                type: .or,
                subpredicates: predicates
            )
            request.predicate = compoundPredicate
        }
        
        return Future<[LocalAnimalPhoto], Error> { [weak context] promise in
            guard let context else { return }
            
            do {
                let photos = try context.fetch(request)
                promise(.success(photos))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func saveFavorite(_ photo: AnimalPhoto) {
        context.performAndWait { [weak context] in
            guard let context else { return }
            do {
                let request = LocalAnimalPhoto.fetchRequest()
                request.predicate = NSPredicate(
                    format: "id == %@",
                    NSNumber(integerLiteral: photo.id)
                )
                request.fetchLimit = 1
                let existingPhotos = try context.fetch(request)
                
                if existingPhotos.first?.id == nil {
                    let newPhoto = LocalAnimalPhoto(context: context)
                    newPhoto.createdAt = Date()
                    newPhoto.id = Int64(photo.id)
                    newPhoto.name = photo.name.rawValue
                    newPhoto.imageURL = photo.imageURL
                    try context.save()
                }
            } catch {
                print("Failed to save favorite to core data: \(error)")
            }
        }
    }
    
    func removeFavorite(_ photo: AnimalPhoto) {
        let request = LocalAnimalPhoto.fetchRequest()
        
        do {
            request.predicate = NSPredicate(
                format: "id == %@", 
                NSNumber(integerLiteral: photo.id)
            )
            request.fetchLimit = 1
            let existingPhotos = try context.fetch(request)
            if let existingPhoto = existingPhotos.first {
                context.delete(existingPhoto)
                try context.save()
            }
        } catch {
            print("Failed to remove favorite to core data: \(error)")
        }
    }
}
