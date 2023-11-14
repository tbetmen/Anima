//
//  AnimalsService.swift
//  Anima
//
//  Created by Muhammad M. Munir on 13/11/23.
//

import Foundation

protocol AnimalsServiceInterface {
    @discardableResult
    func fetchAnimal(
        name: String,
        completion: @escaping (Result<Animal, Error>) -> Void
    ) -> APIServiceCancellableInterface?
}

final class AnimalsService: AnimalsServiceInterface {
    private let transferService: DataTransferServiceInterface
    
    init(transferService: DataTransferServiceInterface = DataTransferService()) {
        self.transferService = transferService
    }
    
    func fetchAnimal(
        name: String,
        completion: @escaping (Result<Animal, Error>) -> Void
    ) -> APIServiceCancellableInterface? {
        let endpoint = AnimalsEndpoint.fetchAnimal(name: name)
        return self.transferService.request(with: endpoint) { result in
            switch result {
            case .success(let responseDTO):
                completion(.success(responseDTO.toEntity(name: name)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
