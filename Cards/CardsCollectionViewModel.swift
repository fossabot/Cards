//
//  CardsCollectionViewModel.swift
//  Cards
//
//  Created by Robert Nash on 14/12/2017.
//  Copyright © 2017 Robert Nash. All rights reserved.
//

import UIKit

class CardsCollectionViewModel<T>: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout where T: CardableScene {
  
  private let cards: [Card<T>]
  
  typealias Selection = (T.CardableSceneModel) -> Void
  
  var didSelect: Selection?
  
  init(cards: [Card<T>]) {
    self.cards = cards
  }
  
  //MARK: UICollectionViewDataSource
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return cards.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let card: Card = cards[indexPath.item]
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionViewCellID", for: indexPath) as! CardCollectionViewCell
    cell.didTap = { [unowned self] in
      self.didSelect?(card.model)
    }
    cell.configure(withScene: card.scene)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    /// Cell layout sometimes breaks after rotation
    cell.layoutIfNeeded()
  }
  
  //MARK: UICollectionViewDelegateFlowLayout
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    var size = collectionView.frame.size
    size.width = pageWidth(collectionView as UIScrollView)
    return size
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  //MARK: UIScrollViewDelegate
  
  private(set) var currentPage: Int = 0
  
  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    currentPage = establishCurrentPage(scrollView)
  }
  
  private func establishCurrentPage(_ scrollView: UIScrollView) -> Int {
    let pw = pageWidth(scrollView)
    let a = scrollView.contentOffset.x
    let b = scrollView.contentInset.left
    let c = (a - b)
    let d = c - pw / 2.0
    let e = d / pw
    return Int(floor(e)) + 1
  }
  
  /// with thanks to https://stackoverflow.com/a/17230270/1951992
  
  func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    
    let pw = pageWidth(scrollView)
    var newPage = currentPage
    if velocity.x == 0 {
      newPage = Int(floor((targetContentOffset.pointee.x - pw / 2) / pw)) + 1
    } else {
      newPage = velocity.x > 0 ? currentPage + 1 : currentPage - 1
    }
    
    if newPage < 0 {
      newPage = 0
    }
    
    if CGFloat(newPage) > scrollView.contentSize.width / pw {
      newPage = Int(ceil(scrollView.contentSize.width / pw)) - 1
    }
    
    targetContentOffset.pointee.x = (CGFloat(newPage) * pw) - scrollView.contentInset.left
  }
  
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    if decelerate == false {
      currentPage = establishCurrentPage(scrollView)
    }
  }
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    currentPage = establishCurrentPage(scrollView)
  }
  
  private func pageWidth(_ scrollView: UIScrollView) -> CGFloat {
    let width = scrollView.frame.size.width
    let left: CGFloat = scrollView.contentInset.left
    let right: CGFloat = scrollView.contentInset.right
    return width - (left + right)
  }
}
