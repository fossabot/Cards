import UIKit
import Cards

final class ViewController: UIViewController {
  
  @IBOutlet private var currentSelectionLabel: UILabel!
  
  private var cardsManager: CardsManager<DanceClassViewController>!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = blue
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

final class DanceClassViewController: UIViewController, CardableScene {
  
  private let tableViewModel: DanceClassTableViewModel
  
  private let tableView = DanceClassTableView()
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "Class"
    navigationController?.navigationBar.titleTextAttributes = [.font: fontA, .foregroundColor: green]
    view.backgroundColor = blue
    tableView.dataSource = tableViewModel
    view.addSubview(tableView)
    
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
      tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
      ])
  }
  
  /// CardableScene
  
  typealias Model = DanceClass
  
  required init(model: Model) {
    self.tableViewModel = DanceClassTableViewModel(danceClass: model)
    super.init(nibName: nil, bundle: nil)
  }
  
  var model: DanceClass {
    return tableViewModel.danceClass
  }
  
  var showsNavigationBar: Bool {
    return true
  }
}
