//
//  VerticalViewController.swift
//  Example
//
//  Created by Takuma Horiuchi on 2018/02/03.
//  Copyright © 2018年 Takuma Horiuchi. All rights reserved.
//

import UIKit

final class VerticalViewController: UIViewController {

    @IBOutlet weak var showButton: UIButton! {
        didSet {
            showButton.tintColor = .white
            showButton.showsTouchWhenHighlighted = true
            showButton.setTitle("Show", for: .normal)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Vertical"
        view.backgroundColor = UIColor(hex: ColorHex.lightBlue)
    }

    @IBAction func tapShowButton(_ sender: Any) {
        let viewController = DetailViewController.make(bgColor: UIColor(hex: ColorHex.lightYellow))
        navigationController?.show(viewController, sender: nil)
    }
}
