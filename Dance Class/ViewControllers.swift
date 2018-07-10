import UIKit
import Cards

final class HomeViewController: UIViewController {
  
  private let feedbackLabel: UILabel = {
    let view = UILabel()
    view.textColor = .white
    view.textAlignment = .center
    view.font = fontB
    view.text = "No Selection"
    return view
  }()
  
  private let cardsManager: CardsManager<DanceClassViewController> = {
    let scenes = DanceClassGenerator.generate().map(DanceClassViewController.init)
    return CardsManager(scenes: scenes)
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = blue
    view.addSubview(feedbackLabel)
    
    feedbackLabel.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      feedbackLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      feedbackLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
      feedbackLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
      ])
    
    cardsManager.dismiss = { [unowned self] in
      self.dismiss(animated: true, completion: nil)
    }
    cardsManager.didSelect = { [unowned self] danceClass in
      self.feedbackLabel.text = "Current selection is \(danceClass.town)"
      self.dismiss(animated: true, completion: nil)
    }
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognized(_:)))
    view.addGestureRecognizer(tapGesture)
  }
  
  @objc func tapGestureRecognized(_ sender: UITapGestureRecognizer) {
    present(cardsManager.selectionsScene, animated: true, completion: nil)
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
}

final class DanceClassViewController: UIViewController, CardableScene {
  
  private let tableViewModel: TableViewModel
  
  private let tableView = TableView()
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    let view = UIView()
    view.backgroundColor = blue
    self.view = view
  }
  
  override var navigationController: UINavigationController? {
    let navigationController = super.navigationController
    navigationController?.navigationBar.titleTextAttributes = [.font: fontA, .foregroundColor: green]
    return navigationController
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Class"
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
    self.tableViewModel = TableViewModel(danceClass: model)
    super.init(nibName: nil, bundle: nil)
  }
  
  var model: DanceClass {
    return tableViewModel.danceClass
  }
  
  var showsNavigationBar: Bool {
    return true
  }
}
