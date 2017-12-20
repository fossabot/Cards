//
//  CardCollectionViewCell.swift
//  Cards
//
//  Created by Robert Nash on 14/12/2017.
//  Copyright © 2017 Robert Nash. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
  
  private var viewController: UIViewController?
  
  /// After calling this function, add scene as a child view controller.
  func configure(withScene scene: UIViewController) {
    viewController?.view.removeFromSuperview()
    viewController?.removeFromParentViewController()
    viewController?.didMove(toParentViewController: nil)
    addSubview(scene.view)
    viewController = scene
  }
  
  private func makePanGestureRecognizer() -> UIPanGestureRecognizer {
    let selector = #selector(panGestureRecognized(_:))
    let gesture = UIPanGestureRecognizer(target: self, action: selector)
    gesture.minimumNumberOfTouches = 1
    gesture.maximumNumberOfTouches = 1
    return gesture
  }
  
  @objc private func panGestureRecognized(_ sender: UIPanGestureRecognizer) {
    guard let touchedView = sender.view else { return }
    let translation: CGPoint = sender.translation(in: self)
    let x: CGFloat = touchedView.center.x + translation.x
    let y: CGFloat = touchedView.center.y + translation.y
    touchedView.center = CGPoint(x: x, y: y)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    clipsToBounds = true
    viewController?.view.frame = bounds
    layer.cornerRadius = min(bounds.width, bounds.height) / 14.0
  }
}
