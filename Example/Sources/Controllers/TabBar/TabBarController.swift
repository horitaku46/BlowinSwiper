//
//  TabBarController.swift
//  Example
//
//  Created by Takuma Horiuchi on 2018/02/03.
//  Copyright © 2018年 Takuma Horiuchi. All rights reserved.
//

import UIKit

final class TabBarController: UITabBarController {

    private enum Const {
        static let tabBarTitles = ["First"]
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        for (index, title) in Const.tabBarTitles.enumerated() {
            tabBar.items?[index].title = title
        }
    }
}
