//
//  FontManager.swift
//  RotaryWheelDemo
//
//  Created by Nash Software Consulting Ltd on 09/03/2017.
//  Copyright © 2017 Robert Nash. All rights reserved.
//

import UIKit

struct FontManager {
  
    private static let fontA = UIFont(name: "AvenirNext-DemiBold", size: UIDevice.current.userInterfaceIdiom == .pad ? 40.0 : 20.0)!
    private static let fontB = UIFont(name: "AvenirNext-DemiBold", size: UIDevice.current.userInterfaceIdiom == .pad ? 52.0 : 26.0)!
    private static let fontC = UIFont(name: "AvenirNext-Medium", size: UIDevice.current.userInterfaceIdiom == .pad ? 48.0 : 24.0)!
    private static let fontD = UIFont(name: "AvenirNext-Regular", size: UIDevice.current.userInterfaceIdiom == .pad ? 40.0 : 20.0)!
    
    //MARK: FontA
    
    static let navigationBarTitle = fontA
    static let subtitle = fontA
    static let emphasisedBody = fontA
    
    //MARK: FontB
    
    static let navigationBarLargeTitle = fontB
    
    //MARK: FontC
    
    static let heading = fontC
    
    //MARK: FontD
    
    static let body = fontD
    
}
