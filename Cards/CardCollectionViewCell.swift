//
//  CardCollectionViewCell.swift
//  Cards
//
//  Created by Robert Nash on 14/12/2017.
//  Copyright © 2017 Robert Nash. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
  
  private let blockerView: UIView
  
  typealias TapAction = () -> Void
  
  var didTap: TapAction?
  
  private var tapGesture: UITapGestureRecognizer!
  
  @objc func tappy(_ sender: UITapGestureRecognizer) {
    didTap?()
  }
  
  override init(frame: CGRect) {
    blockerView = UIView()
    super.init(frame: frame)
    clipsToBounds = true
    addSubview(blockerView)
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappy(_:)))
    blockerView.addGestureRecognizer(tapGesture)
    self.tapGesture = tapGesture
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(withScene scene: UINavigationController) {
    addSubview(scene.view)
    bringSubviewToFront(blockerView)
    if let scrollView = scrollView(on: scene.viewControllers.first!.view) {
      tapGesture.require(toFail: scrollView.panGestureRecognizer)
      blockerView.addGestureRecognizer(scrollView.panGestureRecognizer)
    }
  }

  private func scrollView(on view: UIView) -> UIScrollView? {
    for subview in view.subviews {
      if subview is UIScrollView {
        return subview as? UIScrollView
      }
    }
    return nil
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    for subview in subviews {
      if subview != blockerView {
        subview.removeFromSuperview()
      }
    }
    for gesture in blockerView.gestureRecognizers ?? [] {
      blockerView.removeGestureRecognizer(gesture)
    }
    blockerView.addGestureRecognizer(self.tapGesture)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    for subview in subviews {
      subview.frame = bounds
    }
    layer.cornerRadius = min(bounds.width, bounds.height) / 14.0
  }
}
