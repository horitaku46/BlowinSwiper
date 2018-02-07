//
//  DetailViewController.swift
//  Example
//
//  Created by Takuma Horiuchi on 2018/02/03.
//  Copyright © 2018年 Takuma Horiuchi. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController {

    private var bgColor = UIColor.white

    class func make(bgColor: UIColor) -> UIViewController {
        let viewController = UIStoryboard(name: "DetailViewController", bundle: nil)
            .instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        viewController.bgColor = bgColor
        return viewController
    }

    var blowinSwiper: BlowinSwiper?

    override func viewDidLoad() {
        super.viewDidLoad()

        let label = UILabel()
        label.text = "Detail"
        label.font = .boldSystemFont(ofSize: 17)
        navigationItem.titleView = label
        view.backgroundColor = bgColor

        // test
        if bgColor == UIColor(hex: ColorHex.purple) {
            blowinSwiper = BlowinSwiper(navigationController: navigationController)
            navigationController?.delegate = blowinSwiper
        }

//        let target = navigationController?.value(forKey: "_cachedInteractionController")
//        let recognizer = UIPanGestureRecognizer(target: target, action: Selector(("handleNavigationTransition:")))
//        view.addGestureRecognizer(recognizer)
    }
}

//2018-02-07 03:19:39.589496+0900 Example[6948:4143703] <_UISystemGestureGateGestureRecognizer: 0x1c41ca320>: Gesture: Failed to receive system gesture state notification before next touch
//2018-02-07 03:19:39.589877+0900 Example[6948:4143703] <_UISystemGestureGateGestureRecognizer: 0x1c41ca410>: Touch: Failed to receive system gesture state notification before next touch
