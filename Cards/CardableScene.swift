//
//  Cardable.swift
//  Cards
//
//  Created by Robert Nash on 20/12/2017.
//  Copyright © 2017 Robert Nash. All rights reserved.
//

import UIKit

private struct AssociatedKeys {
  static var model: UInt8 = 0
}

/// https://bugs.swift.org/browse/SR-6265

public protocol CardableScene: class where Self: UIViewController {
    associatedtype CardableSceneModel
    var showsNavigationBar: Bool { get }
    var model: CardableSceneModel? { get }
}

//public extension CardableScene {
//
//    /// https://bugs.swift.org/browse/SR-6657
//
//    var showsNavigationBar: Bool {
//      return navigationItem.title != nil
//    }
//}

public extension CardableScene {
  
  var model: CardableSceneModel? {
    get {
      guard let value = objc_getAssociatedObject(self, &AssociatedKeys.model) as? CardableSceneModel else {
        return nil
      }
      return value
    }
    set {
      objc_setAssociatedObject(self as Any, &AssociatedKeys.model, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }
  
  var showsNavigationBar: Bool {
    return true
  }
}

