//
//  DanceClassGenerator.swift
//  DanceClass
//
//  Created by Robert Nash on 20/12/2017.
//  Copyright © 2017 Robert Nash. All rights reserved.
//

import Foundation

struct DanceClassGenerator {
    
    static func generate() -> [DanceClass] {
        return decodeClasses()
    }
    
    static func decodeClasses() -> [DanceClass] {
        let url: URL = Bundle.main.url(forResource: "data", withExtension: "json")!
        let data = try! String(contentsOf: url).data(using: .utf8)!
        return try! JSONDecoder().decode([DanceClass].self, from: data)
    }
}
