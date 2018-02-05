//
//  BlowinSwiper.swift
//  BlowinSwiper
//
//  Created by Takuma Horiuchi on 2018/02/02.
//  Copyright © 2018年 Takuma Horiuchi. All rights reserved.
//

import UIKit

final class BlowinSwiper: UIPercentDrivenInteractiveTransition {

    private var navigationController: UINavigationController?

    private var isPop = false
    private var percentageDriven = false

    private let scale: CGFloat = 0.95

    init(navigationController: UINavigationController?) {
        super.init()
        self.navigationController = navigationController
        setup()
    }

    private func setup() {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        gesture.delegate = self
        navigationController?.view.addGestureRecognizer(gesture)
    }
}

extension BlowinSwiper {

    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        guard let view = gesture.view else {
            return
        }

        var percent = gesture.location(in: view).x / view.bounds.width / 2.0
        percent = percent < 1 ? percent : 0.99
        percentageDriven = true

        switch gesture.state {
        case .began:
            navigationController?.popViewController(animated: true)

        case .changed:
            update(percent)

        case .ended, .cancelled:
            gesture.velocity(in: view).x < 0 ? cancel() : finish()
            percentageDriven = false

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
        isPop = operation == .pop
        return self
    }

    func navigationController(_ navigationController: UINavigationController,
                              interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return percentageDriven ? self : nil
    }
}

extension BlowinSwiper: UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from),
            let toViewController = transitionContext.viewController(forKey: .to) else {
            return
        }
        let containerView = transitionContext.containerView

        let fromView = isPop ? toViewController.view : fromViewController.view
        let toView   = isPop ? fromViewController.view : toViewController.view
        let offSet   = containerView.bounds.width

        containerView.insertSubview(toViewController.view, aboveSubview: fromViewController.view)
        if isPop {
            containerView.insertSubview(toViewController.view, belowSubview: fromViewController.view)
        }

        toView?.frame = containerView.frame
        toView?.transform = isPop ? CGAffineTransform.identity : CGAffineTransform(translationX: offSet, y: 0)
        fromView?.frame = containerView.frame
        fromView?.transform = isPop ? CGAffineTransform(scaleX: scale, y: scale) : CGAffineTransform.identity

        let duration = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, animations: {
            toView?.transform = self.isPop ? CGAffineTransform(translationX: offSet, y: 0) : CGAffineTransform.identity
            fromView?.transform = self.isPop ? CGAffineTransform.identity : CGAffineTransform(scaleX: self.scale, y: self.scale)
        }) { _ in
            toView?.transform = CGAffineTransform.identity
            fromView?.transform = CGAffineTransform.identity
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
