//
//  BlowinSwiper.swift
//  BlowinSwiper
//
//  Created by Takuma Horiuchi on 2018/02/02.
//  Copyright © 2018年 Takuma Horiuchi. All rights reserved.
//

import UIKit

public final class BlowinSwiper: NSObject {

    deinit {
        guard let panGesture = panGesture else { return }
        panGesture.removeTarget(self, action: #selector(handlePanGesture(_:)))
        navigationController?.view.removeGestureRecognizer(panGesture)
    }

    private struct Const {
        static let maxSwipeVelocityX: CGFloat = 500
    }

    public weak var panGesture: UIPanGestureRecognizer?
    public var isShouldRecognizeSimultaneously = false
    public var isLowSensitivity = false

    private var navigationController: UINavigationController?
    private var percentDriven = UIPercentDrivenInteractiveTransition()
    private var isInteractivePop = false

    public init(navigationController: UINavigationController?) {
        super.init()
        self.navigationController = navigationController

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        panGesture.delegate = self
        self.navigationController?.view.addGestureRecognizer(panGesture)
        self.panGesture = panGesture
    }

    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        guard let view = gesture.view else {
            return
        }

        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)

        switch gesture.state {
        case .began:
            // only right swipe
            let isZeroTransitionY = isLowSensitivity ? translation.y == 0 : true
            if translation.x > 0 && isZeroTransitionY {
                isInteractivePop = true
                navigationController?.popViewController(animated: true)
            }

        case .changed:
            let percent = translation.x > 0 ? translation.x / view.bounds.width : 0
            percentDriven.update(percent)

        case .ended, .cancelled:
            isInteractivePop = false
            let maxWidth = view.bounds.width / 3
            velocity.x > Const.maxSwipeVelocityX || translation.x > maxWidth ? percentDriven.finish() : percentDriven.cancel()

        default:
            break
        }
    }
}

extension BlowinSwiper: UIGestureRecognizerDelegate {

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return navigationController?.viewControllers.count ?? 0 > 1
    }

    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return isShouldRecognizeSimultaneously
    }
}

extension BlowinSwiper: UINavigationControllerDelegate {

    public func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationControllerOperation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .pop:
            return PopAnimatedTransitioning(isInteractivePop: isInteractivePop)

        default:
            return nil
        }
    }

    public func navigationController(_ navigationController: UINavigationController,
                              interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return isInteractivePop ? percentDriven : nil
    }
}
