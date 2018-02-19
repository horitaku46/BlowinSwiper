//
//  BlowinSwiper.swift
//  BlowinSwiper
//
//  Created by Takuma Horiuchi on 2018/02/02.
//  Copyright © 2018年 Takuma Horiuchi. All rights reserved.
//

import UIKit

final class BlowinSwiper: NSObject {

    deinit {
        guard let panGesture = panGesture else { return }
        panGesture.removeTarget(self, action: #selector(handlePanGesture(_:)))
        navigationController?.view.removeGestureRecognizer(panGesture)
    }

    private struct Const {
        static let maxSwipeVelocity: CGFloat = 800
    }

    var isShouldRecognizeSimultaneously = false

    private var navigationController: UINavigationController?
    private weak var panGesture: UIPanGestureRecognizer?
    private var percentDriven = UIPercentDrivenInteractiveTransition()
    private var isInteractivePop = false

    init(navigationController: UINavigationController?) {
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

        let translationX = gesture.translation(in: view).x
        let velocityX = gesture.velocity(in: view).x

        switch gesture.state {
        case .began:
            // only right swipe
            if velocityX > 0 {
                isInteractivePop = true
                navigationController?.popViewController(animated: true)
            }

        case .changed:
            let percent = translationX > 0 ? translationX / view.bounds.width : 0
            percentDriven.update(percent)

        case .ended, .cancelled:
            isInteractivePop = false
            let halfWidth = view.bounds.width / 2
            velocityX > Const.maxSwipeVelocity || translationX > halfWidth ? percentDriven.finish() : percentDriven.cancel()

        default:
            break
        }
    }
}

extension BlowinSwiper: UIGestureRecognizerDelegate {

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return navigationController?.viewControllers.count ?? 0 > 1
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return isShouldRecognizeSimultaneously
    }
}

extension BlowinSwiper: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController,
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

    func navigationController(_ navigationController: UINavigationController,
                              interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return isInteractivePop ? percentDriven : nil
    }
}
