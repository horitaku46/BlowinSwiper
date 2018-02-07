//
//  HorizontalPopAnimatedTransitioning.swift
//  Example
//
//  Created by Takuma Horiuchi on 2018/02/06.
//  Copyright © 2018年 Takuma Horiuchi. All rights reserved.
//

import UIKit

final class HorizontalPopAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {

    private struct Const {
        static let toViewTransitionRatio: CGFloat = 0.3
        static let titleViewTransitionRatio: CGFloat = 0.52
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from),
            let toViewController = transitionContext.viewController(forKey: .to) else {
            return
        }
        let containerView = transitionContext.containerView
        let fromVCTitleView = fromViewController.navigationItem.titleView
        let toViewWidth = toViewController.view.bounds.width

        containerView.insertSubview(toViewController.view, belowSubview: fromViewController.view)

        toViewController.view.frame.origin.x = -toViewWidth * Const.toViewTransitionRatio

        UIView.animate(withDuration: transitionDuration(using: transitionContext),
                       animations: {
            toViewController.view.frame.origin.x = 0
            fromViewController.view.frame.origin.x = toViewWidth
            fromVCTitleView?.frame.origin.x = toViewWidth * Const.titleViewTransitionRatio
        }) { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
