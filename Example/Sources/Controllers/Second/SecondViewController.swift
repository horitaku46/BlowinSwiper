//
//  SecondViewController.swift
//  Example
//
//  Created by Takuma Horiuchi on 2018/02/03.
//  Copyright © 2018年 Takuma Horiuchi. All rights reserved.
//

import UIKit

final class SecondViewController: UIViewController, BlowinSwipeable {

    class func make() -> SecondViewController {
        let viewController = UIStoryboard(name: "SecondViewController", bundle: nil)
            .instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        viewController.hidesBottomBarWhenPushed = true
        return viewController
    }

    @IBOutlet weak var toolBar: UIToolbar! {
        didSet {
            toolBar.barTintColor = .darkGray
        }
    }

    var blowinSwiper: BlowinSwiper?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = UILabel.navigationItemTitle("Second")
        view.backgroundColor = UIColor(hex: ColorHex.purple)

        let leftBackBarButtonItem = UIBarButtonItem(title: "≪",
                                                    style: .plain,
                                                    target: self,
                                                    action: #selector(tapLeftBackBarButtonItem))
        navigationItem.setLeftBarButton(leftBackBarButtonItem, animated: true)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureSwipeBack()
    }

    @objc private func tapLeftBackBarButtonItem() {
        navigationController?.popViewController(animated: true)
    }
}
