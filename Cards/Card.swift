//
//  Card.swift
//  Cards
//
//  Created by Robert Nash on 14/12/2017.
//  Copyright © 2017 Robert Nash. All rights reserved.
//

import UIKit

struct Card<T> where T: CardableScene {
  
  enum Error: Swift.Error {
    case modelMissing
  }
  
  let scene: UINavigationController
  let model: T.CardableSceneModel
  
  init(scene: T) throws {
    guard scene.model != nil else {
      throw Error.modelMissing
    }
    self.model = scene.model!
    let navigationController = UINavigationController(rootViewController: scene)
    navigationController.isNavigationBarHidden = (scene.showsNavigationBar == false)
    self.scene = navigationController
  }
}
