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

        containerView.insertSubview(toViewController.view, belowSubview: fromViewController.view)

        UIView.animate(withDuration: transitionDuration(using: transitionContext),
                       animations: {
            fromViewController.view.frame.origin.x = toViewController.view.bounds.width
            fromVCTitleView?.frame.origin.x = toViewController.view.bounds.width * Const.titleViewTransitionRatio
        }) { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
