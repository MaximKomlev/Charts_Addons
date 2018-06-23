//
//  AnimatedTransitioning.swift
//  Charts_Addons_Demo
//
//  Created by Maxim Komlev on 6/15/18.
//  Copyright © 2018 Maxim Komlev. All rights reserved.
//

import UIKit
import Foundation

let TransitionDuration = 0.325

public enum TransitioningDirection {
    case up, down, left, right, none
}

class AnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {

    // MARK: Fields
    
    var _direction: TransitioningDirection = .right
    var _transition: SwipeInteractiveTransition?
    
    // MARK: Initializers/Deinitializer

    required init(direction: TransitioningDirection, transition: SwipeInteractiveTransition? = nil) {
        super.init()
        
        _direction = direction
        _transition = transition
    }

    // MARK: Properties
    
    var transitionController: SwipeInteractiveTransition? {
        get {
            return _transition
        }
    }
    
    // MARK: UIViewControllerAnimatedTransitioning
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return TransitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
                return
        }
        
        let originFrame = fromVC.view.frame
        if (self._direction == .right) {
            toVC.view.frame = originFrame.offsetBy(dx: originFrame.width, dy: 0)
        } else if (self._direction == .left) {
            toVC.view.frame = originFrame.offsetBy(dx: -originFrame.width, dy: 0)
        }
        
        let containerView = transitionContext.containerView
        
        let snapshot = fromVC.view.snapshotView(afterScreenUpdates: false)
        if let snapshot = snapshot {
            containerView.addSubview(snapshot)
        }

        containerView.addSubview(toVC.view)
        fromVC.view.isHidden = true
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, delay: 0, options: [.curveEaseInOut], animations: {
            if (self._direction == .right) {
                toVC.view.frame = originFrame.offsetBy(dx: 0, dy: 0)
                snapshot?.frame = originFrame.offsetBy(dx: -originFrame.width, dy: 0)
            } else if (self._direction == .left) {
                toVC.view.frame = originFrame.offsetBy(dx: 0, dy: 0)
                snapshot?.frame = originFrame.offsetBy(dx: originFrame.width, dy: 0)
            }
        }) { (success) in
            fromVC.view.isHidden = false
            snapshot?.removeFromSuperview()
            if transitionContext.transitionWasCancelled {
                toVC.view.removeFromSuperview()
            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
    }
}
