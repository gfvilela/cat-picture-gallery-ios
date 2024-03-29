//
//  ImagesRepository.swift
//  CatPictureGallery
//
//  Created by Gustavo Freitas Vilela on 09/03/23.
//

import Foundation

protocol GalleriesRepository {
    func fetchGalleryImagesCatList(completion: @escaping (Result<[Gallery], Error>) -> Void)
}
