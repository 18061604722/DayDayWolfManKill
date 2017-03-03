//
//  EasyAnimator.swift
//  DayDayWolfmanKill
//
//  Created by yyj on 2017/3/2.
//  Copyright © 2017年 yyj. All rights reserved.
//

import Foundation
import UIKit

class EasyAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return 0.3
    }
    
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        let containView = transitionContext.containerView
        
        var fromView = fromVC?.view
        var toView = toVC?.view
        
        if transitionContext.responds(to: #selector(UIViewControllerTransitionCoordinatorContext.view(forKey:))) {
            fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)
            toView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        }
        
//        toView?.frame = CGRect(x: 0, y: 400, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        toView?.alpha = 0
        if toView != nil {
            containView.addSubview(toView!)
        }
        
        let transitionDuration = self.transitionDuration(using: transitionContext)
        UIView.animate(withDuration: transitionDuration, animations: {
            if toView == nil {
                fromView?.alpha = 0
            } else {
                toView?.alpha = 1
//                toView?.frame = CGRect.init(x: 0, y: 299, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            }
        }) { (finished: Bool) -> Void in
            let wasCancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!wasCancelled)
        }
    }
}
