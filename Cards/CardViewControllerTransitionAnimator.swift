//
//  ViewControllerTransitionAnimator.swift
//  Cards
//
//  Created by Robert Nash on 14/12/2017.
//  Copyright © 2017 Robert Nash. All rights reserved.
//

import UIKit

class CardViewControllerTransitionAnimator: NSObject {
  
  var isPresentation: Bool = false
  
  fileprivate let animationGroup = DispatchGroup()
  
}

extension CardViewControllerTransitionAnimator: UIViewControllerAnimatedTransitioning {
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.3
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    
//    let homeController = transitionContext.viewController(forKey: isPresentation ? .from : .to)!
    let detailController = transitionContext.viewController(forKey: isPresentation ? .to : .from)!
    
    if isPresentation {
      transitionContext.containerView.addSubview(detailController.view)
    }
    
    let presentedFrame = transitionContext.finalFrame(for: detailController)
    var dismissedFrame = presentedFrame
    dismissedFrame.origin.y = transitionContext.containerView.frame.size.height
    
    let initialFrame = isPresentation ? dismissedFrame : presentedFrame
    let finalFrame = isPresentation ? presentedFrame : dismissedFrame
    
    let animationDuration = transitionDuration(using: transitionContext)
    detailController.view.frame = initialFrame
    
    animationGroup.enter()
    
    UIView.animate(withDuration: animationDuration,
                   delay: 0,
                   usingSpringWithDamping: 300,
                   initialSpringVelocity: 5,
                   options: .beginFromCurrentState,
                   animations: {
                    detailController.view.frame = finalFrame
    }) { finished in
      self.animationGroup.leave()
    }
    
//    animationGroup.enter()
//
//    UIView.animate(withDuration: animationDuration,
//                   delay: animationDuration / 3.0,
//                   usingSpringWithDamping: 900,
//                   initialSpringVelocity: 5,
//                   options: .beginFromCurrentState,
//                   animations: {
//                    homeController.view.transform = self.isPresentation ? homeController.view.transform.scaledBy(x: 0.9, y: 0.9) : CGAffineTransform.identity
//    }) { finished in
//      self.animationGroup.leave()
//    }
    
    animationGroup.notify(queue: DispatchQueue.main) {
      transitionContext.completeTransition(true)
    }
    
  }
  
}
