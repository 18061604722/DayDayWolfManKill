//
//  CustomPresentationController.swift
//  DayDayWolfmanKill
//
//  Created by yyj on 2017/3/2.
//  Copyright © 2017年 yyj. All rights reserved.
//

import Foundation
import UIKit

class CustomPresentationController: UIPresentationController {
    
//    var dimmingView: UIView? = nil
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
        presentedViewController.modalPresentationStyle = .custom
    }
}



extension CustomPresentationController {
    
    override func presentationTransitionWillBegin() {
        
//        dimmingView = UIView.init(frame: (self.containerView?.bounds)!)
//        dimmingView?.backgroundColor = UIColor.red
//        
//        self.containerView?.addSubview(dimmingView!)
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
    }
    
    override func dismissalTransitionWillBegin() {
        let transitionCoordinator = self.presentingViewController.transitionCoordinator
        transitionCoordinator?.animate(alongsideTransition: { (context: UIViewControllerTransitionCoordinatorContext) -> Void in
        }, completion: nil)
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
    }
}

extension CustomPresentationController: UIViewControllerTransitioningDelegate {

    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return self
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return EasyAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return EasyAnimator()
    }
}






