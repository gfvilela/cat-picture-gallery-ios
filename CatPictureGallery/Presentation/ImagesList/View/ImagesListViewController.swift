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

        imagesListCollectionView.imagesListDelegate = self
        self.loadingView.isHidden = false
        viewModel.items = { [weak self] images in
            DispatchQueue.main.async {
                self?.loadingView.isHidden = true
                self?.imagesListCollectionView.items = images
            }
        }
        viewModel.error = { [weak self] _ in
            var dialogMessage = UIAlertController(title: "Error", message: "An error occurred while trying to load the images", preferredStyle: .alert)
            let retry = UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
                self?.viewModel.didLoad()
            })

            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            dialogMessage.addAction(retry)
            dialogMessage.addAction(cancel)
            self?.present(dialogMessage, animated: true, completion: nil)
        }
        viewModel.didLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationViewController = segue.destination as? ImageDetailsViewController else {
            return
        }

        if let imageSender = sender as? Image {
            destinationViewController.image = imageSender
        }
    }
}

extension ImagesListViewController: ImagesListViewModelActions {
    func showImageDetail(image: Image) {
        performSegue(withIdentifier: "showImageDetail", sender: image)
    }
}

extension ImagesListViewController: ImagesListCollectionViewDelegate {
    func didSelectItem(indexPath: IndexPath) {
        viewModel.didSelect(index: indexPath.item)
    }
}

