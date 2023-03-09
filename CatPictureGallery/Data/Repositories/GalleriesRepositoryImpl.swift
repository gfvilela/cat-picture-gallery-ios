//
//  GaleriesRepositoryImpl.swift
//  CatPictureGallery
//
//  Created by Gustavo Freitas Vilela on 09/03/23.
//

import Foundation

class GalleriesRepositoryImpl: GalleriesRepository {
    private let galleryService: GalleryService

    init(galleryService: GalleryService) {
        self.galleryService = galleryService
    }

    init() {
        self.galleryService = GalleryServiceImpl()
    }

    func fetchGalleryImagesCatList(completion: @escaping (Result<[Gallery], Error>) -> Void) {
        galleryService.fetchGalleriesImagesCat { result in
            switch result {
            case .success(let galleries):
                if let galleries = galleries {
                    completion(Result.success(galleries))
                } else {
                    completion(Result.failure(RepositoryError.malformatedResponse))
                }
            case.failure(let error):
                completion(Result.failure(error))
            }
        }
    }
}
