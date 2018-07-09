//
//  DanceClassTableView.swift
//  DanceClass
//
//  Created by Robert Nash on 19/12/2017.
//  Copyright © 2017 Robert Nash. All rights reserved.
//

import UIKit
import Dequable

class DanceClassTableView: UITableView, DequeableTableView {
    
    init(style: UITableViewStyle) {
        super.init(frame: .zero, style: style)
        separatorStyle = .none
        register(cellType: DanceClassTableViewCell.self, hasXib: true)
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
