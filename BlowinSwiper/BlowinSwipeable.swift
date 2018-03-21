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
    func configureSwipeBack(isLowSensitivity: Bool)
    func enabledRecognizeSimultaneously(scrollView: UIScrollView?)
    func disabledRecognizeSimultaneously()
    func handleScrollRecognizeSimultaneously(scrollView: UIScrollView?)
}

public extension BlowinSwipeable where Self: UIViewController {

    public func configureSwipeBack(isLowSensitivity: Bool = false) {
        guard let navigationController = navigationController else { return }
        blowinSwiper = BlowinSwiper(navigationController: navigationController)
        blowinSwiper?.isLowSensitivity = isLowSensitivity
        navigationController.delegate = blowinSwiper
    }

    // MARK: - Swipe back and scrollView handling

    public func enabledRecognizeSimultaneously(scrollView: UIScrollView?) {
        guard let scrollView = scrollView else { return }
        if scrollView.contentOffset.x == 0 {
            blowinSwiper?.isShouldRecognizeSimultaneously = true
        } else {
            blowinSwiper?.isShouldRecognizeSimultaneously = false
        }
    }

    public func disabledRecognizeSimultaneously() {
        blowinSwiper?.isShouldRecognizeSimultaneously = false
    }

    public func handleScrollRecognizeSimultaneously(scrollView: UIScrollView?) {
        guard let scrollView = scrollView else { return }
        if floor(scrollView.contentOffset.x) == 0 {
            blowinSwiper?.isShouldRecognizeSimultaneously = true
        } else {
            blowinSwiper?.isShouldRecognizeSimultaneously = false
        }
    }
}
