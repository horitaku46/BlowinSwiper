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
        static let absoluteInsensitiveRangeY: CGFloat = 10
    }

    public weak var panGesture: UIPanGestureRecognizer?
    public var isShouldRecognizeSimultaneously = false
    public var isInsensitive = false

    private var navigationController: UINavigationController?
    private var percentDriven = UIPercentDrivenInteractiveTransition()
    private var isInteractivePop = false
    private var isDecideBack = false
    private var isOnceGestureBegan = true

    public init(navigationController: UINavigationController?) {
        super.init()
        self.navigationController = navigationController

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        panGesture.delegate = self
        self.navigationController?.view.addGestureRecognizer(panGesture)
        self.panGesture = panGesture
    }

    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        // order not to the extra swipe during screen transition.
        // When swiping before instance is destroyed.
        if isDecideBack { return }

        guard let view = gesture.view else { return }
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)

        // iPad is less sensitive to gesture than the iPhone.
        // Because iPad gets zero when the state starts, it does not know the direction.
        if translation == .zero { return }
        if isOnceGestureBegan {
            // only right swipe
            let isZeroTransitionY = isInsensitive ? isInsensitiveRangeY(translation.y) : true
            if translation.x > 0 && isZeroTransitionY {
                isInteractivePop = true
                navigationController?.popViewController(animated: true)
            }
            isOnceGestureBegan = false
        }

        switch gesture.state {
        case .changed:
            let percent = translation.x > 0 ? translation.x / view.bounds.width : 0
            percentDriven.update(percent)

        case .ended, .failed, .cancelled:
            if isInteractivePop {
                let maxWidth = view.bounds.width / 3
                isDecideBack = velocity.x > Const.maxSwipeVelocityX || translation.x > maxWidth
                isDecideBack ? percentDriven.finish() : percentDriven.cancel()
                isInteractivePop = false
            }
            isOnceGestureBegan = true

        default:
            break
        }
    }

    private func isInsensitiveRangeY(_ translationY: CGFloat) -> Bool {
        let y = Const.absoluteInsensitiveRangeY
        if case -y...y = translationY { return true }
        return false
    }
}

extension BlowinSwiper: UIGestureRecognizerDelegate {

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return navigationController?.viewControllers.count ?? 0 > 1
    }

    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                                  shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return isShouldRecognizeSimultaneously
    }
}

extension BlowinSwiper: UINavigationControllerDelegate {

    public func navigationController(_ navigationController: UINavigationController,
                                     animationControllerFor operation: UINavigationController.Operation,
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
