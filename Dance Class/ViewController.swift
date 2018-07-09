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
  
  private lazy var cardsManager: CardsManager<DanceClassViewController> = {
    let danceClasses: [DanceClass] = DanceClassGenerator.decodeClasses()
    let scenes: [DanceClassViewController] = danceClasses.map { danceClass in
      return DanceClassViewController(model: danceClass)
    }
    return CardsManager<DanceClassViewController>(scenes: scenes)
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = ColourManager.background
    
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
