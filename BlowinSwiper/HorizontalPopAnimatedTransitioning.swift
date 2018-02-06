//
//  HorizontalPopAnimatedTransitioning.swift
//  Example
//
//  Created by Takuma Horiuchi on 2018/02/06.
//  Copyright © 2018年 Takuma Horiuchi. All rights reserved.
//

import UIKit

final class HorizontalPopAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from),
            let toViewController = transitionContext.viewController(forKey: .to) else {
            return
        }
        let containerView = transitionContext.containerView

        containerView.insertSubview(toViewController.view, belowSubview: fromViewController.view)

        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            fromViewController.view.transform = CGAffineTransform(translationX: toViewController.view.bounds.width, y: 0)
        }) { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
