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
  var parentViewController: UIViewController?
  
  typealias Selection = (T.Model) -> Void
  
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
    let cell: CardCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionViewCellID", for: indexPath) as! CardCollectionViewCell
    cell.configure(withScene: card.scene)
    parentViewController?.addChildViewController(card.scene)
    card.scene.didMove(toParentViewController: parentViewController)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let card: Card = cards[indexPath.item]
    let scene = (card.scene.viewControllers.first as! T)
    didSelect?(scene.model)
  }
  
  //MARK: UICollectionViewDelegateFlowLayout
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    var size = collectionView.frame.size
    size.width = cellWidth(collectionView as UIScrollView)
    return size
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  //MARK: UIScrollViewDelegate
  
  private var currentPage: Int = 0
  
  private func pageWidth(_ scrollView: UIScrollView) -> CGFloat {
    return cellWidth(scrollView)
  }
  
  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    let pw = pageWidth(scrollView)
    let a = scrollView.contentOffset.x
    let b = scrollView.contentInset.left
    currentPage = Int(floor(((a - b) - pw / 2.0) / pw)) + 1;
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
  
  private func cellWidth(_ scrollView: UIScrollView) -> CGFloat {
    let width = scrollView.frame.size.width
    let left: CGFloat = scrollView.adjustedContentInset.left
    let right: CGFloat = scrollView.adjustedContentInset.right
    return width - (left + right)
  }
  
}
