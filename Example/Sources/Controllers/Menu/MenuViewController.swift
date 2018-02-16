//
//  MenuViewController.swift
//  Example
//
//  Created by Takuma Horiuchi on 2018/02/03.
//  Copyright © 2018年 Takuma Horiuchi. All rights reserved.
//

import UIKit

final class MenuViewController: SwipeMenuViewController {


    class func make() -> UIViewController {
        let viewController = UIStoryboard(name: "MenuViewController", bundle: nil)
            .instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        return viewController
    }

    private let viewColor = [UIColor(hex: ColorHex.green),
                             UIColor(hex: ColorHex.purple),
                             UIColor(hex: ColorHex.lightBlue),
                             UIColor(hex: ColorHex.lightYellow)]

    private var blowinSwiper: BlowinSwiper?

    override func viewDidLoad() {
        super.viewDidLoad()

        let menuLabel = UILabel()
        menuLabel.text = "Menu"
        menuLabel.font = UIFont.boldSystemFont(ofSize: 17)
        navigationItem.titleView = menuLabel

        var options = SwipeMenuViewOptions()
        options.tabView.style = .segmented
        options.tabView.underlineView.backgroundColor = .black
        options.tabView.itemView.textColor = .gray
        options.tabView.itemView.selectedTextColor = .black
        swipeMenuView.reloadData(options: options)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        swipeMenuView.contentScrollView?.isScrollEnabled = true

        blowinSwiper = BlowinSwiper(navigationController: navigationController)
        navigationController?.delegate = blowinSwiper
        blowinSwiper?.isShouldRecognizeSimultaneously = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        swipeMenuView.contentScrollView?.isScrollEnabled = false
    }

    // MARK: - SwipeMenuViewDelegate

    override func swipeMenuViewDidScroll(_ contentScrollView: UIScrollView) {
        if floor(contentScrollView.contentOffset.x) == 0 {
            blowinSwiper?.isShouldRecognizeSimultaneously = true
        } else {
            blowinSwiper?.isShouldRecognizeSimultaneously = false
        }
    }

    // MARK: - SwipeMenuViewDataSource

    override func numberOfPages(in swipeMenuView: SwipeMenuView) -> Int {
        return viewColor.count
    }

    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, titleForPageAt index: Int) -> String {
        return String(index + 1)
    }

    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewControllerForPageAt index: Int) -> UIViewController {
        let viewController = UIViewController()
        viewController.view.backgroundColor = viewColor[index]
        return viewController
    }
}
