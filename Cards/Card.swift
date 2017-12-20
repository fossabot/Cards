//
//  Card.swift
//  Cards
//
//  Created by Robert Nash on 14/12/2017.
//  Copyright © 2017 Robert Nash. All rights reserved.
//

import UIKit

struct Card<T> where T: CardableScene {
  
  let scene: UINavigationController
  
  init(scene: T) {
    let navigationController = UINavigationController(rootViewController: scene)
    navigationController.isNavigationBarHidden = (scene.showsNavigationBar == false)
    self.scene = navigationController
  }
}
