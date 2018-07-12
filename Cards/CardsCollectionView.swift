//
//  CardsCollectionView.swift
//  Cards
//
//  Created by Robert Nash on 14/12/2017.
//  Copyright © 2017 Robert Nash. All rights reserved.
//

import UIKit

class CardsCollectionView: UICollectionView {
  
  init() {
    super.init(frame: .zero, collectionViewLayout: CardsCollectionViewLayout())
    translatesAutoresizingMaskIntoConstraints = false
    clipsToBounds = false
    decelerationRate = UIScrollView.DecelerationRate.fast
    backgroundColor = .clear
    showsVerticalScrollIndicator = false
    showsHorizontalScrollIndicator = false
    register(CardCollectionViewCell.self, forCellWithReuseIdentifier: "CardCollectionViewCellID")
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func adjustInsets(parentSize: CGSize) {
    let inset: CGFloat = parentSize.width * 0.2
    contentInset.left = inset / 2.0
    contentInset.right = inset / 2.0
  }
  
  override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    let hitView = super.hitTest(point, with: event)
    if hitView == self && indexPathForItem(at: point) == nil {
      return self.superview
    }
    return hitView
  }
}
