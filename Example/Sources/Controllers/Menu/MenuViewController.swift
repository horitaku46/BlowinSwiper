//
//  MenuViewController.swift
//  Example
//
//  Created by Takuma Horiuchi on 2018/02/03.
//  Copyright © 2018年 Takuma Horiuchi. All rights reserved.
//

import UIKit

final class MenuViewController: UIViewController, BlowinSwipeable {

    class func make() -> MenuViewController {
        let viewController = UIStoryboard(name: "MenuViewController", bundle: nil)
            .instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        return viewController
    }

    @IBOutlet weak var swipeMenuView: SwipeMenuView! {
        didSet {
            swipeMenuView.options.tabView.style                         = .segmented
            swipeMenuView.options.tabView.underlineView.backgroundColor = .black
            swipeMenuView.options.tabView.itemView.textColor            = .gray
            swipeMenuView.options.tabView.itemView.selectedTextColor    = .black
            swipeMenuView.delegate = self
            swipeMenuView.dataSource = self
        }
    }

    private let viewColor = [UIColor(hex: ColorHex.green),
                             UIColor(hex: ColorHex.purple),
                             UIColor(hex: ColorHex.lightBlue),
                             UIColor(hex: ColorHex.lightYellow)]

    var viewControllers = [ColorViewController]()

    var blowinSwiper: BlowinSwiper?

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.titleView = UILabel.navigationItemTitle("Menu")

        let rightShowBarButtonItem = UIBarButtonItem(title: "Show",
                                                     style: .plain,
                                                     target: self,
                                                     action: #selector(tapRightShowBarButtonItem))
        navigationItem.setRightBarButton(rightShowBarButtonItem, animated: true)

        viewColor.forEach { viewControllers.append(ColorViewController.make(backgroundColor: $0)) }
        swipeMenuView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Enable scrolling by putting finger back during swipe back
        swipeMenuView.contentScrollView?.isScrollEnabled = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureSwipeBack(isInsensitive: true)
        enabledRecognizeSimultaneously(scrollView: swipeMenuView.contentScrollView)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Stop the scrollView while swiping back
        swipeMenuView.contentScrollView?.isScrollEnabled = false
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        disabledRecognizeSimultaneously()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        swipeMenuView.willChangeOrientation()
    }

    @objc private func tapRightShowBarButtonItem() {
        let viewController = SecondViewController.make()
        navigationController?.show(viewController, sender: nil)
    }
}

extension MenuViewController: SwipeMenuViewDelegate {

    func swipeMenuViewDidScroll(_ contentScrollView: UIScrollView) {
        handleScrollRecognizeSimultaneously(scrollView: contentScrollView)
    }
}

extension MenuViewController: SwipeMenuViewDataSource {

    func numberOfPages(in swipeMenuView: SwipeMenuView) -> Int {
        return viewControllers.count
    }

    func swipeMenuView(_ swipeMenuView: SwipeMenuView, titleForPageAt index: Int) -> String {
        return String(index + 1)
    }

    func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewControllerForPageAt index: Int) -> UIViewController {
        return viewControllers[index]
    }
}
