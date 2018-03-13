//
//  BlowinSwipeable.swift
//  Example
//
//  Created by Takuma Horiuchi on 2018/02/19.
//  Copyright © 2018年 Takuma Horiuchi. All rights reserved.
//

import UIKit

public protocol BlowinSwipeable: class {
    var blowinSwiper: BlowinSwiper? { get set }
    func setSwipeBack()
}

public extension BlowinSwipeable where Self: UIViewController {

    public func setSwipeBack() {
        guard let navigationController = self.navigationController else { return }
        blowinSwiper = BlowinSwiper(navigationController: navigationController)
        navigationController.delegate = blowinSwiper
    }

    // MARK: - Swipe back and scrollView handling

    public func enabledRecognizeSimultaneously(scrollView: UIScrollView? = nil) {
        if scrollView?.contentOffset.x == 0 {
            blowinSwiper?.isShouldRecognizeSimultaneously = true
        }
    }

    public func disabledRecognizeSimultaneously() {
        blowinSwiper?.isShouldRecognizeSimultaneously = false
    }

    public func handleScrollRecognizeSimultaneously(scrollView: UIScrollView) {
        if floor(scrollView.contentOffset.x) == 0 {
            blowinSwiper?.isShouldRecognizeSimultaneously = true
        } else {
            blowinSwiper?.isShouldRecognizeSimultaneously = false
        }
    }
}
