//
//  BlowinSwiper.swift
//  BlowinSwiper
//
//  Created by Takuma Horiuchi on 2018/02/02.
//  Copyright © 2018年 Takuma Horiuchi. All rights reserved.
//

import UIKit

final class BlowinSwiper: NSObject {

    private struct Const {
        static let maxSwipeVelocity: CGFloat = 800
    }

    private var navigationController: UINavigationController?
    private var percentDriven = UIPercentDrivenInteractiveTransition() {
        didSet {
            percentDriven.completionCurve = .easeOut
        }
    }

    init(navigationController: UINavigationController?) {
        super.init()
        self.navigationController = navigationController

        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        gesture.delegate = self
        self.navigationController?.view.addGestureRecognizer(gesture)
    }

    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        guard let view = gesture.view else {
            return
        }

        let translationX = gesture.translation(in: view).x

        switch gesture.state {
        case .began:
            navigationController?.popViewController(animated: true)

        case .changed:
            let percent = translationX > 0 ? translationX / view.bounds.width : 0
            percentDriven.update(percent)

        case .ended, .cancelled:
            let velocityX = gesture.velocity(in: view).x
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
}

extension BlowinSwiper: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationControllerOperation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .pop:
            return HorizontalPopAnimatedTransitioning()

        default:
            return nil
        }
    }

    func navigationController(_ navigationController: UINavigationController,
                              interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return percentDriven
    }
}

//extension BlowinSwiper: UIViewControllerAnimatedTransitioning {
//
//    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//        return 0.3
//    }
//
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        guard let fromViewController = transitionContext.viewController(forKey: .from),
//            let toViewController = transitionContext.viewController(forKey: .to) else {
//            return
//        }
//        let containerView = transitionContext.containerView
//
//        let fromView = isPop ? toViewController.view : fromViewController.view
//        let toView   = isPop ? fromViewController.view : toViewController.view
//        let offSet   = containerView.bounds.width
//
//        containerView.insertSubview(toViewController.view, aboveSubview: fromViewController.view)
//        if isPop {
//            containerView.insertSubview(toViewController.view, belowSubview: fromViewController.view)
//        }
//
//        toView?.frame = containerView.frame
//        toView?.transform = isPop ? CGAffineTransform.identity : CGAffineTransform(translationX: offSet, y: 0)
//        fromView?.frame = containerView.frame
//        fromView?.transform = isPop ? CGAffineTransform(scaleX: scale, y: scale) : CGAffineTransform.identity
//
//        let duration = transitionDuration(using: transitionContext)
//        UIView.animate(withDuration: duration, animations: {
//            toView?.transform = self.isPop ? CGAffineTransform(translationX: offSet, y: 0) : CGAffineTransform.identity
//            fromView?.transform = self.isPop ? CGAffineTransform.identity : CGAffineTransform(scaleX: self.scale, y: self.scale)
//        }) { _ in
//            toView?.transform = CGAffineTransform.identity
//            fromView?.transform = CGAffineTransform.identity
//            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
//        }
//    }
//}

