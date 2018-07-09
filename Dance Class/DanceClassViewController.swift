//
//  DanceClassViewController.swift
//  DanceClass
//
//  Created by Robert Nash on 19/12/2017.
//  Copyright © 2017 Robert Nash. All rights reserved.
//

import UIKit
import Cards

class DanceClassViewController: UIViewController, CardableScene {
  
    private let tableViewModel: DanceClassTableViewModel
  
    //MARK: CardableScene
  
    typealias Model = DanceClass
  
    required init(model: DanceClass) {
      self.tableViewModel = DanceClassTableViewModel(danceClass: model)
      super.init(nibName: nil, bundle: nil)
    }
  
    var model: DanceClass {
      return tableViewModel.danceClass
    }
  
    var showsNavigationBar: Bool {
      return true
    }
    
    private let tableView = DanceClassTableView(style: .plain)
  
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Class"
        navigationController?.navigationBar.titleTextAttributes = [.font: FontManager.navigationBarTitle, .foregroundColor: ColourManager.text]
        view.backgroundColor = ColourManager.background
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = tableViewModel
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
