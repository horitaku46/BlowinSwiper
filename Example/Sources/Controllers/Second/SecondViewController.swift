//
//  SecondViewController.swift
//  Example
//
//  Created by Takuma Horiuchi on 2018/02/03.
//  Copyright © 2018年 Takuma Horiuchi. All rights reserved.
//

import UIKit

final class SecondViewController: UIViewController {

    class func make() -> UIViewController {
        let viewController = UIStoryboard(name: "SecondViewController", bundle: nil)
            .instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        return viewController
    }

    private var blowinSwiper: BlowinSwiper?

    override func viewDidLoad() {
        super.viewDidLoad()

        let menuLabel = UILabel()
        menuLabel.text = "Second"
        menuLabel.font = UIFont.boldSystemFont(ofSize: 17)
        navigationItem.titleView = menuLabel

        view.backgroundColor = UIColor(hex: ColorHex.purple)

        let leftBackBarButtonItem = UIBarButtonItem(title: "←",
                                                     style: .plain,
                                                     target: self,
                                                     action: #selector(tapLeftBackBarButtonItem))
        navigationItem.setLeftBarButton(leftBackBarButtonItem, animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        blowinSwiper = BlowinSwiper(navigationController: navigationController)
        navigationController?.delegate = blowinSwiper
    }

    @objc private func tapLeftBackBarButtonItem() {
        navigationController?.popViewController(animated: true)
    }
}
