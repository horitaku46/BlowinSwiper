//
//  MenuViewController.swift
//  Example
//
//  Created by Takuma Horiuchi on 2018/02/03.
//  Copyright © 2018年 Takuma Horiuchi. All rights reserved.
//

import UIKit

final class MenuViewController: UIViewController, BlowinSwipeable {

    class func make() -> UIViewController {
        let viewController = UIStoryboard(name: "MenuViewController", bundle: nil)
            .instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        return viewController
    }

    @IBOutlet weak var swipeMenuView: SwipeMenuView! {
        didSet {
            var options = SwipeMenuViewOptions()
            options.tabView.style                         = .segmented
            options.tabView.underlineView.backgroundColor = .black
            options.tabView.itemView.textColor            = .gray
            options.tabView.itemView.selectedTextColor    = .black
            swipeMenuView.delegate = self
            swipeMenuView.dataSource = self
            swipeMenuView.reloadData(options: options)
        }
    }

    private let viewColor = [UIColor(hex: ColorHex.green),
                             UIColor(hex: ColorHex.purple),
                             UIColor(hex: ColorHex.lightBlue),
                             UIColor(hex: ColorHex.lightYellow)]

    var blowinSwiper: BlowinSwiper?

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.titleView = UILabel.navigationItemTitle("Menu")

        let rightShowBarButtonItem = UIBarButtonItem(title: "Show",
                                                     style: .plain,
                                                     target: self,
                                                     action: #selector(tapRightShowBarButtonItem))
        navigationItem.setRightBarButton(rightShowBarButtonItem, animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Enable scrolling by putting finger back during swipe back
        swipeMenuView.contentScrollView?.isScrollEnabled = true

        configureSwipeBack()
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
        return viewColor.count
    }

    func swipeMenuView(_ swipeMenuView: SwipeMenuView, titleForPageAt index: Int) -> String {
        return String(index + 1)
    }

    func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewControllerForPageAt index: Int) -> UIViewController {
        let viewController = ColorViewController.make(self, backgroundColor: viewColor[index])
        return viewController
    }
}
