//
//  ImagesCatUseCase.swift
//  CatPictureGallery
//
//  Created by Gustavo Freitas Vilela on 09/03/23.
//

import Foundation

protocol ImagesCatUseCase {
    func execute(completion: @escaping (Result<[Image], Error>) -> Void) -> Cancellable?
}

final class ImagesCatUseCaseImpl: ImagesCatUseCase {
    private let galeriesRepository: GaleriesRepository

    init(galeriesRepository: GaleriesRepository) {
        self.galeriesRepository = galeriesRepository
    }

    func execute(completion: @escaping (Result<[Image], Error>) -> Void) -> Cancellable? {
        return galeriesRepository.fetchGalleryImagesCatList { resultFetch in
            switch resultFetch {
            case .success(let galleries):
                var images: [Image] = []
                galleries.compactMap( { $0.images }).forEach { imagesFromGallery in
                    images.append(contentsOf: imagesFromGallery)
                }
                completion(Result.success(images))
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
}
