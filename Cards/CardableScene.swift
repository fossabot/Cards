//
//  Cardable.swift
//  Cards
//
//  Created by Robert Nash on 20/12/2017.
//  Copyright © 2017 Robert Nash. All rights reserved.
//

import UIKit

/// https://bugs.swift.org/browse/SR-6265

public protocol CardableScene: class where Self: UIViewController {
  associatedtype Model
  var showsNavigationBar: Bool { get }
  init(model: Model)
  var model: Model { get }
}

//public extension CardableScene {
//
//  var showsNavigationBar: Bool {
//    return navigationItem.title != nil
//  }
//}

