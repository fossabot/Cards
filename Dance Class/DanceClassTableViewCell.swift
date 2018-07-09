//
//  DanceClassTableViewCell.swift
//  DanceClass
//
//  Created by Robert Nash on 20/12/2017.
//  Copyright © 2017 Robert Nash. All rights reserved.
//

import UIKit
import Dequable

class DanceClassTableViewCell: UITableViewCell, DequeableComponentIdentifiable {
    
    @IBOutlet private var labelOne: UILabel! {
        didSet {
            labelOne.font = FontManager.subtitle
            labelOne.textColor = ColourManager.text
        }
    }
    
    @IBOutlet private var dividerView: UIView! {
        didSet {
            dividerView.backgroundColor = ColourManager.divider
        }
    }
  
    @IBOutlet private weak var textField: UITextField! {
      didSet {
        textField.font = FontManager.body
        textField.textColor = ColourManager.text
      }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = .clear
    }
    
    func configure(withTitle title: String, withSubtitle subtitle: String) {
        labelOne.text = title
        textField.text = subtitle
    }
    
}
