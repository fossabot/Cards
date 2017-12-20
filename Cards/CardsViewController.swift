//
//  CardsViewController.swift
//  Cards
//
//  Created by Robert Nash on 14/12/2017.
//  Copyright © 2017 Robert Nash. All rights reserved.
//

import UIKit

protocol CardsViewControllerDelegate: class {
  func cardsViewController(touchesEnded touches: Set<UITouch>, with event: UIEvent?)
}

class CardsViewController<T>: UIViewController where T: CardableScene {
  
  weak var delegate: CardsViewControllerDelegate?
  
  let model: CardsCollectionViewModel<T>
  
  init(model: CardsCollectionViewModel<T>) {
    self.model = model
    super.init(nibName: nil, bundle: Bundle(for: CardsCollectionView.self))
    self.model.parentViewController = self
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let collectionView = CardsCollectionView()
    view.addSubview(collectionView)
    collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    collectionView.dataSource = model
    collectionView.delegate = model
    let inset: CGFloat = view.frame.size.width * 0.2
    collectionView.contentInset.left = inset / 2.0
    collectionView.contentInset.right = inset / 2.0
    delegate = presentationController as? CardsViewControllerDelegate
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    delegate?.cardsViewController(touchesEnded: touches, with: event)
  }
}
