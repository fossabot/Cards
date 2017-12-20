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
    backgroundColor = .clear
    showsVerticalScrollIndicator = false
    showsHorizontalScrollIndicator = false
    register(CardCollectionViewCell.self, forCellWithReuseIdentifier: "CardCollectionViewCellID")
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    let hitView = super.hitTest(point, with: event)
    if hitView == self && indexPathForItem(at: point) == nil {
      /// Outside of card area should dismiss. Superview will delegate the touch.
      return self.superview
    }
    return hitView
  }
  
}
