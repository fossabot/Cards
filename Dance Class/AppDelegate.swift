//
//  AppDelegate.swift
//  Dance Class
//
//  Created by Robert Nash on 14/12/2017.
//  Copyright © 2017 Robert Nash. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    UINavigationBar.appearance().tintColor = ColourManager.text
    UINavigationBar.appearance().barTintColor = ColourManager.navigationBar
    return true
  }

}
