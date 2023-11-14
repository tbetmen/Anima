//
//  ListScreenViewModel.swift
//  Anima
//
//  Created by Muhammad M. Munir on 13/11/23.
//

import Foundation
import Combine

final class ListScreenViewModel: ObservableObject {
    @Published public var animals = [Animal]()
    @Published public var isLoading = true
    
    private let service: AnimalsServiceInterface
    
    init(service: AnimalsServiceInterface = AnimalsService()) {
        self.service = service
    }
    
    public func loadAnimals() {
        isLoading = true
        
        if !animals.isEmpty {
            isLoading = false
            return
        }
        
        
        let dispatchGroup = DispatchGroup()
        var animalsTemp = [Animal]()
        for animalQuery in AnimalType.allCases {
            dispatchGroup.enter()
            service.fetchAnimal(name: animalQuery.rawValue) { result in
                switch result {
                case .success(let animal):
                    animalsTemp.append(animal)
                case .failure:()
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.animals = animalsTemp
            self?.isLoading = false
        }
    }
}
