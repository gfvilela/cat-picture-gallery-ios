//
//  GalleriesRepositoryMock.swift
//  CatPictureGalleryTests
//
//  Created by Gustavo Freitas Vilela on 10/03/23.
//

import XCTest
@testable import CatPictureGallery

class GalleriesRepositoryMock: GalleriesRepository {
    var resultMock: Result<[CatPictureGallery.Gallery], Error> = Result.success([])
    func fetchGalleryImagesCatList(completion: @escaping (Result<[Gallery], Error>) -> Void) {
        completion(resultMock)
    }
}
