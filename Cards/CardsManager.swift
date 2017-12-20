//
//  CardsManager.swift
//  Cards
//
//  Created by Robert Nash on 14/12/2017.
//  Copyright © 2017 Robert Nash. All rights reserved.
//

import UIKit

public class CardsManager<T>: CardViewControllerPresentationControllerDelegate where T: CardableScene {
    
  private let transitionHandler: CardViewControllerTransitionHandler
   
  public typealias Selection = (T.Model) -> Void
  public typealias DismissAction = () -> Void
  
  public var didSelect: Selection?
  public var dismiss: DismissAction?
  
  private let cards: [Card<T>]
  
  public private(set) lazy var selectionsScene: UIViewController = { [unowned self] in
    let model = CardsCollectionViewModel<T>(cards: self.cards)
    model.didSelect = self.didSelect
    let controller = CardsViewController<T>(model: model)
    controller.modalPresentationStyle = .custom
    controller.transitioningDelegate = transitionHandler
    return controller as UIViewController
  }()
  
  public init(scenes: [T]) {
    self.cards = scenes.map {
      return Card<T>(scene: $0)
    }
    self.transitionHandler = CardViewControllerTransitionHandler()
    self.transitionHandler.interactionDelegate = self
  }
  
  //MARK: CardViewControllerPresentationControllerDelegate
  
  func viewControllerPresentationControllerChromeAreaTapped(_ controller: CardViewControllerPresentationController) {
    dismiss?()
  }
}
