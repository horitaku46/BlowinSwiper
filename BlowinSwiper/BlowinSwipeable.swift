//
//  BlowinSwipeable.swift
//  Example
//
//  Created by Takuma Horiuchi on 2018/02/19.
//  Copyright © 2018年 Takuma Horiuchi. All rights reserved.
//

import UIKit

protocol BlowinSwipeable: class {
    var blowinSwiper: BlowinSwiper? { get set }
    func setSwipeBack()

    func enabledRecognizeSimultaneously(scrollView: UIScrollView?)
    func disabledRecognizeSimultaneously(scrollView: UIScrollView?)
    func handleScrollRecognizeSimultaneously(scrollView: UIScrollView)
}

extension BlowinSwipeable where Self: UIViewController {

    func setSwipeBack() {
        guard let navigationController = self.navigationController else { return }
        blowinSwiper = BlowinSwiper(navigationController: navigationController)
        navigationController.delegate = blowinSwiper
    }

    // MARK: - Swipe back and scrollView handling

    func enabledRecognizeSimultaneously(scrollView: UIScrollView? = nil) {
        if scrollView?.contentOffset.x == 0 {
            blowinSwiper?.isShouldRecognizeSimultaneously = true
        }
    }

    func disabledRecognizeSimultaneously(scrollView: UIScrollView? = nil) {
        blowinSwiper?.isShouldRecognizeSimultaneously = false
    }

    func handleScrollRecognizeSimultaneously(scrollView: UIScrollView) {
        if floor(scrollView.contentOffset.x) == 0 {
            blowinSwiper?.isShouldRecognizeSimultaneously = true
        } else {
            blowinSwiper?.isShouldRecognizeSimultaneously = false
        }
    }
}
