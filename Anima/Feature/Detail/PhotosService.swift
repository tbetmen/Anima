//
//  PhotosService.swift
//  Anima
//
//  Created by Muhammad M. Munir on 13/11/23.
//

import Foundation

protocol PhotosServiceInterface {
    @discardableResult
    func fetchPhotos(
        name: String,
        completion: @escaping (Result<[AnimalPhoto], Error>) -> Void
    ) -> APIServiceCancellableInterface?
}

final class PhotosService: PhotosServiceInterface {
    private let transferService: DataTransferServiceInterface
    
    init(transferService: DataTransferServiceInterface = DataTransferService()) {
        self.transferService = transferService
    }
    
    func fetchPhotos(
        name: String,
        completion: @escaping (Result<[AnimalPhoto], Error>) -> Void
    ) -> APIServiceCancellableInterface? {
        let endpoint = PhotosEndpoint.fetchPhotos(name: name)
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
