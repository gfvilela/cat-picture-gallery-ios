//
//  ImageDetailsViewController.swift
//  CatPictureGallery
//
//  Created by Gustavo Freitas Vilela on 10/03/23.
//

import UIKit
import Kingfisher

class ImageDetailsViewController: UIViewController {
    @IBOutlet weak var descriptionDetail: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    var image: Image?

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpImageDetail()
    }

    private func setUpImageDetail() {
        guard let link = image?.link else {
            return
        }
        imageView.kf.setImage(with: URL(string: link), options: [
            .transition(.fade(0.25)),
            .backgroundDecode
        ])

        guard let description = image?.description else {
            return
        }
        descriptionDetail.text = description
    }
}
