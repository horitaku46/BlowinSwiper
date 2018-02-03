//
//  HorizonViewController.swift
//  Example
//
//  Created by Takuma Horiuchi on 2018/02/03.
//  Copyright © 2018年 Takuma Horiuchi. All rights reserved.
//

import UIKit

final class HorizonViewController: UIViewController {

    @IBOutlet weak var showButton: UIButton! {
        didSet {
            showButton.tintColor = .white
            showButton.showsTouchWhenHighlighted = true
            showButton.setTitle("Show", for: .normal)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Horizon"
        view.backgroundColor = UIColor(hex: ColorHex.green)
    }

    @IBAction func tapShowButton(_ sender: Any) {
        let viewController = DetailViewController.make(bgColor: UIColor(hex: ColorHex.purple))
        navigationController?.show(viewController, sender: nil)
    }
}
