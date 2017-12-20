//
//  ViewControllerPresentationController.swift
//  Cards
//
//  Created by Robert Nash on 14/12/2017.
//  Copyright © 2017 Robert Nash. All rights reserved.
//

import UIKit

class PresentationController: UIPresentationController {
  
  fileprivate var dimmingView: UIView!
  
  var dismissalCompletion: (() -> Void)?
  
  override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
    super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    setupDimmingView()
  }
  
  override func presentationTransitionWillBegin() {
    if let containerView = containerView {
      containerView.insertSubview(dimmingView, at: 0)
      dimmingView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
      dimmingView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
      dimmingView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
      dimmingView.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
    }
    guard let coordinator = presentedViewController.transitionCoordinator else {
      dimmingView.alpha = 1.0
      return
    }
    coordinator.animate(alongsideTransition: { _ in
      self.dimmingView.alpha = 1.0
    })
  }
  
  override var adaptivePresentationStyle: UIModalPresentationStyle {
    return .overFullScreen
  }
  
  override func dismissalTransitionWillBegin() {
    guard let coordinator = presentedViewController.transitionCoordinator else {
      dimmingView.alpha = 0.0
      return
    }
    
    coordinator.animate(alongsideTransition: { _ in
      self.dimmingView.alpha = 0.0
    })
  }
  
  override func dismissalTransitionDidEnd(_ completed: Bool) {
    if completed {
      dismissalCompletion?()
    }
  }
  
  override func containerViewWillLayoutSubviews() {
    presentedView?.frame = frameOfPresentedViewInContainerView
  }
  
  private func setupDimmingView() {
    dimmingView = UIView()
    dimmingView.translatesAutoresizingMaskIntoConstraints = false
    dimmingView.backgroundColor = UIColor(white: 0.0, alpha: 0.4)
    dimmingView.alpha = 0.0
    
    let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
    dimmingView.addGestureRecognizer(recognizer)
  }
  
  @objc func handleTap(recognizer: UITapGestureRecognizer) {
    presentingViewController.dismiss(animated: true)
  }
  
}

protocol CardViewControllerPresentationControllerDelegate: class {
  func viewControllerPresentationControllerChromeAreaTapped(_ controller: CardViewControllerPresentationController)
}

final class CardViewControllerPresentationController: PresentationController {
  
  weak var interactionDelegate: CardViewControllerPresentationControllerDelegate?
  
  override func handleTap(recognizer: UITapGestureRecognizer) {
    interactionDelegate?.viewControllerPresentationControllerChromeAreaTapped(self)
  }
  
  override var frameOfPresentedViewInContainerView: CGRect {
    let childSize = size(forChildContentContainer: presentedViewController, withParentContainerSize: containerView!.bounds.size)
    let containerWidth = containerView!.frame.size.width
    let containerHeight = containerView!.frame.size.height
    let x = (containerWidth - childSize.width) / 2.0
    let y = (containerHeight - childSize.height) / 2.0
    let origin = CGPoint(x: x, y: y)
    return CGRect(origin: origin, size: childSize)
  }
  
  override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
    return CGSize(width: parentSize.width, height: parentSize.height*0.80)
  }
  
}

extension CardViewControllerPresentationController: CardsViewControllerDelegate {
  
  func cardsViewController(touchesEnded touches: Set<UITouch>, with event: UIEvent?) {
    interactionDelegate?.viewControllerPresentationControllerChromeAreaTapped(self)
  }
  
}
