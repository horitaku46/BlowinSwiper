//
//  NavigationController.swift
//  Example
//
//  Created by Takuma Horiuchi on 2018/03/17.
//  Copyright © 2018年 Takuma Horiuchi. All rights reserved.
//

import UIKit

final class NavigationController: UINavigationController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.barTintColor = .darkGray
        navigationBar.tintColor = .white

        interactivePopGestureRecognizer?.delegate = self
    }
}

extension NavigationController: UIGestureRecognizerDelegate {

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
