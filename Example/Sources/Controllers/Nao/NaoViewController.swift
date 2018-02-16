//
//  NaoViewController.swift
//  Example
//
//  Created by Takuma Horiuchi on 2018/02/03.
//  Copyright © 2018年 Takuma Horiuchi. All rights reserved.
//

import UIKit

final class NaoViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.image = UIImage(named: "nao.jpg")
            imageView.contentMode = .scaleAspectFit
        }
    }

    @IBOutlet weak var showButton: UIButton! {
        didSet {
            showButton.tintColor = .white
            showButton.showsTouchWhenHighlighted = true
            showButton.setTitle("Show", for: .normal)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Nao"
        view.backgroundColor = UIColor(hex: ColorHex.green)
    }

    @IBAction func tapShowButton(_ sender: Any) {
        let viewController = MenuViewController.make()
        navigationController?.show(viewController, sender: nil)
    }
}
