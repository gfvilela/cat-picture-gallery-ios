//
//  ViewController.swift
//  CatPictureGallery
//
//  Created by Gustavo Freitas Vilela on 08/03/23.
//

import UIKit

class ImagesListViewController: UIViewController {
    lazy var viewModel: ImagesListViewModel = ImagesListViewModelImpl(actions: self)

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ImagesListViewController: ImagesListViewModelActions {
    func showImageDetail(image: Image) {
        //TODO: Show image detail
    }
}

