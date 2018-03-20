//
//  FirstViewController.swift
//  Example
//
//  Created by Takuma Horiuchi on 2018/02/03.
//  Copyright © 2018年 Takuma Horiuchi. All rights reserved.
//

import UIKit

final class FirstViewController: UIViewController {

    @IBOutlet weak var showButton: UIButton! {
        didSet {
            showButton.tintColor = .white
            showButton.showsTouchWhenHighlighted = true
            showButton.setTitle("Show", for: .normal)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.titleView = UILabel.navigationItemTitle("First")
        view.backgroundColor = UIColor(hex: ColorHex.green)

        let rightShowBarButtonItem = UIBarButtonItem(title: "Show",
                                                     style: .plain,
                                                     target: self,
                                                     action: #selector(tapRightShowBarButtonItem))
        navigationItem.setRightBarButton(rightShowBarButtonItem, animated: true)
    }

    @IBAction func tapShowButton(_ sender: Any) {
        let viewController = MenuViewController.make()
        navigationController?.show(viewController, sender: nil)
    }

    @objc private func tapRightShowBarButtonItem() {
        let viewController = SecondViewController.make()
        navigationController?.show(viewController, sender: nil)
    }
}
