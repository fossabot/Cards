//
//  ViewControllerTransitionHandler.swift
//  Cards
//
//  Created by Robert Nash on 14/12/2017.
//  Copyright © 2017 Robert Nash. All rights reserved.
//

import UIKit

class CardViewControllerTransitionHandler: NSObject {
  
  fileprivate let animator = CardViewControllerTransitionAnimator()
  
  weak var interactionDelegate: CardViewControllerPresentationControllerDelegate?
  
}

extension CardViewControllerTransitionHandler: UIViewControllerTransitioningDelegate {
  
  func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
    let controller = CardViewControllerPresentationController(presentedViewController: presented, presenting: presenting)
    controller.interactionDelegate = interactionDelegate
    return controller
  }
  
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    animator.isPresentation = true
    return animator
  }
  
  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    animator.isPresentation = false
    return animator
  }
  
}
