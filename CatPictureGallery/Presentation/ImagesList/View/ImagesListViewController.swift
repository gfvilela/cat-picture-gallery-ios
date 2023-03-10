//
//  ViewController.swift
//  CatPictureGallery
//
//  Created by Gustavo Freitas Vilela on 08/03/23.
//

import UIKit

class ImagesListViewController: UIViewController {
    @IBOutlet weak var loadingView: UIStackView!
    @IBOutlet weak var imagesListCollectionView: ImagesListCollectionView!
    lazy var viewModel: ImagesListViewModel = ImagesListViewModelImpl(actions: self)

    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadingView.isHidden = false
        viewModel.items = { [weak self] images in
            DispatchQueue.main.async {
                self?.loadingView.isHidden = true
                self?.imagesListCollectionView.items = images
            }
        }
        viewModel.didLoad()
    }
}

extension ImagesListViewController: ImagesListViewModelActions {
    func showImageDetail(image: Image) {
        //TODO: Show image detail
    }
}

