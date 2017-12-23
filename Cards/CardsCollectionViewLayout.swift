//
//  CardsCollectionViewLayout.swift
//  Cards
//
//  Created by Robert Nash on 14/12/2017.
//  Copyright © 2017 Robert Nash. All rights reserved.
//

import UIKit

class CardsCollectionViewLayout: UICollectionViewFlowLayout {
  
  override init() {
    super.init()
    scrollDirection = .horizontal
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    let items = NSArray(array: super.layoutAttributesForElements(in: rect)!, copyItems: true)
    items.enumerateObjects(using: { (object, idex, stop) -> Void in
      let attributes = object as! UICollectionViewLayoutAttributes
      attributes.frame = attributes.frame.insetBy(dx: 10, dy: 10)
    })
    return items as? [UICollectionViewLayoutAttributes]
  }
  
  override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    return true
  }
  
}
