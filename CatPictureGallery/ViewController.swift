//
//  ViewController.swift
//  CatPictureGallery
//
//  Created by Gustavo Freitas Vilela on 08/03/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        //TODO: Remove this code to implement the real logic.
        let useCase = ImagesCatUseCaseImpl()
        useCase.execute { result in
            switch result {
            case .success(let images):
                print("Images Count: \(images.count)")
            case .failure(let error):
                print("Error in \(Self.self).\(#function): \(error)")
            }
        }
    }


}

