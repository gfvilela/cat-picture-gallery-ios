//
//  GaleriesResponseDTO+Mapping.swift
//  CatPictureGallery
//
//  Created by Gustavo Freitas Vilela on 09/03/23.
//

import Foundation

struct GalleriesResponseDTO: Decodable {
    var data: [GalleryDTO]?
}

extension GalleriesResponseDTO {
    struct GalleryDTO: Decodable {
        var id: String?
        var images: [ImagesDTO]?
    }

    struct ImagesDTO: Decodable {
        var id: String?
        var link: String?
        var description: String?
        var type: String?
    }
}

// MARK: - Mappings to Domain

extension GalleriesResponseDTO.GalleryDTO {
    func toDomain() -> Gallery {
        return .init(id: id,
                     images: images?.compactMap({ $0.toDomain() }))
    }
}

extension GalleriesResponseDTO.ImagesDTO {
    func toDomain() -> Image {
        return .init(id: id, link: link, description: description, type: type)
    }
}
