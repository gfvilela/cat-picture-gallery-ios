//
//  ImagesListViewModel.swift
//  CatPictureGallery
//
//  Created by Gustavo Freitas Vilela on 09/03/23.
//

import Foundation

protocol ImagesListViewModelInput {
    func didLoad()
    func didSelect(index: Int)
}

protocol ImagesListViewModelOutput {
    var items: (([Image]) -> Void)? { get set }
    var error: ((Error) -> Void)? { get set }
}

protocol ImagesListViewModel: ImagesListViewModelInput, ImagesListViewModelOutput { }

protocol ImagesListViewModelActions {
    func showImageDetail(image: Image)
}

final class ImagesListViewModelImpl: ImagesListViewModel {
    private let imagesCatUseCase: ImagesCatUseCase
    private let actions: ImagesListViewModelActions?

    private var images: [Image] = [] {
        didSet {
            items?(images)
        }
    }

    var items: (([Image]) -> Void)?
    var error: ((Error) -> Void)?

    init(imagesCatUseCase: ImagesCatUseCase = ImagesCatUseCaseImpl(),
         actions: ImagesListViewModelActions? = nil) {
        self.imagesCatUseCase = imagesCatUseCase
        self.actions = actions
    }

    func didLoad() {
        imagesCatUseCase.execute { [weak self] result in
            switch result {
            case .success(let images):
                self?.images = images
            case .failure(let error):
                self?.error?(error)
            }
        }
    }

    func didSelect(index: Int) {
        let image = images[index]
        actions?.showImageDetail(image: image)
    }
}
