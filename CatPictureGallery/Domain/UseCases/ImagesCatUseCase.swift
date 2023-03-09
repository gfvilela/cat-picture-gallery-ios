//
//  ImagesCatUseCase.swift
//  CatPictureGallery
//
//  Created by Gustavo Freitas Vilela on 09/03/23.
//

import Foundation

protocol ImagesCatUseCase {
    func execute(completion: @escaping (Result<[Image], Error>) -> Void)
}

final class ImagesCatUseCaseImpl: ImagesCatUseCase {
    private let galeriesRepository: GalleriesRepository

    init(galeriesRepository: GalleriesRepository) {
        self.galeriesRepository = galeriesRepository
    }

    init() {
        self.galeriesRepository = GalleriesRepositoryImpl()
    }

    func execute(completion: @escaping (Result<[Image], Error>) -> Void) {
        return galeriesRepository.fetchGalleryImagesCatList { resultFetch in
            switch resultFetch {
            case .success(let galleries):
                var medias: [Image] = []
                galleries.compactMap( { $0.images }).forEach { imagesFromGallery in
                    medias.append(contentsOf: imagesFromGallery)
                }
                let images = medias.filter({ ($0.type ?? "").contains("image") })
                completion(Result.success(images))
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
}
