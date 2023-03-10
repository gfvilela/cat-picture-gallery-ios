//
//  ImageCollectionViewCell.swift
//  CatPictureGallery
//
//  Created by Gustavo Freitas Vilela on 10/03/23.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!

    func loadImageFrom(link: String) {
        imageView.loadFrom(URLAddress: link)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}

extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }

//        let dispatchImage = DispatchQueue(label: "image")
        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                    DispatchQueue.main.async { [weak self] in
                        self?.image = loadedImage
                    }
                }
            }
        }
    }
}
