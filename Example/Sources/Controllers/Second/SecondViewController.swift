//
//  SecondViewController.swift
//  Example
//
//  Created by Takuma Horiuchi on 2018/02/03.
//  Copyright © 2018年 Takuma Horiuchi. All rights reserved.
//

import UIKit

final class SecondViewController: UIViewController, BlowinSwipeable {

    class func make() -> UIViewController {
        let viewController = UIStoryboard(name: "SecondViewController", bundle: nil)
            .instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        return viewController
    }

    var blowinSwiper: BlowinSwiper?

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.titleView = UILabel.navigationItemTitle("Second")

        view.backgroundColor = UIColor(hex: ColorHex.purple)

        let leftBackBarButtonItem = UIBarButtonItem(title: "←",
                                                     style: .plain,
                                                     target: self,
                                                     action: #selector(tapLeftBackBarButtonItem))
        navigationItem.setLeftBarButton(leftBackBarButtonItem, animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setSwipeBack()
    }

    @objc private func tapLeftBackBarButtonItem() {
        navigationController?.popViewController(animated: true)
    }
}
