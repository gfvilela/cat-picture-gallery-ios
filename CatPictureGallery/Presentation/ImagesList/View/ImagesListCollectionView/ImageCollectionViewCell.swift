//
//  ImageCollectionViewCell.swift
//  CatPictureGallery
//
//  Created by Gustavo Freitas Vilela on 10/03/23.
//

import UIKit
import Kingfisher

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!

    func loadImageFrom(link: String) {
        guard let url = URL(string: link) else {
            return
        }
        imageView.kf.setImage(with: url, options: [
            .transition(.fade(0.25)),
            .backgroundDecode
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.kf.cancelDownloadTask()
        imageView.image = nil
    }
}
