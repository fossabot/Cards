//
//  ViewController.swift
//  Dance Class
//
//  Created by Robert Nash on 14/12/2017.
//  Copyright © 2017 Robert Nash. All rights reserved.
//
 
import UIKit
import Cards

class ViewController: UIViewController {
  
  @IBOutlet private var currentSelectionLabel: UILabel!
  
  private var cardsManager: CardsManager<DanceClassViewController>!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = ColourManager.background
    let scenes = DanceClassGenerator.generate().map(DanceClassViewController.init)
    cardsManager = CardsManager(scenes: scenes)
    cardsManager.dismiss = { [unowned self] in
        self.dismiss(animated: true, completion: nil)
    }
    cardsManager.didSelect = { [unowned self] danceClass in
        self.currentSelectionLabel.text = "Current selection is \(danceClass.town)"
        self.dismiss(animated: true, completion: nil)
    }
  }
  
  @IBAction private func tapGestureRecognized(_ sender: UITapGestureRecognizer) {
    present(cardsManager.selectionsScene, animated: true, completion: nil)
  }
}
