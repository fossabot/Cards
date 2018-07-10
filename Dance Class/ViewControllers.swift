import UIKit
import Cards
import Gradient

class GradientViewController: UIViewController {
  
  var color1: CGColor {
    fatalError("Must override")
  }
  
  var color2: CGColor {
    fatalError("Must override")
  }
  
  var color3: CGColor {
    fatalError("Must override")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    var gradientView: GradientView!
    var colors: [CGColor]!
    var coordinates: Coordinates
    
    colors = [color1, color2]
    coordinates = GradientPoint.leftRight.coordinates
    gradientView = GradientView(colors: colors, coordinates: coordinates)
    view.addSubview(gradientView)
    
    gradientView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      gradientView.topAnchor.constraint(equalTo: view.topAnchor),
      gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      gradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
      ])
    
    colors = [color3, UIColor.clear.cgColor]
    coordinates = Coordinates(x: CGPoint(x: 0.2, y: 1), y: CGPoint(x: 0.7, y: 0))
    gradientView = GradientView(colors: colors, coordinates: coordinates)
    view.addSubview(gradientView)
    
    gradientView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      gradientView.topAnchor.constraint(equalTo: view.topAnchor),
      gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      gradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
      ])
  }
}

final class HomeViewController: GradientViewController {
  
  override var color1: CGColor {
    return #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).cgColor
  }
  
  override var color2: CGColor {
    return #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1).cgColor
  }
  
  override var color3: CGColor {
    return UIColor.purple.cgColor
  }
  
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
  
  private lazy var feedbackLabelConstraints1: [NSLayoutConstraint] = {
    return [
      feedbackLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      feedbackLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
      feedbackLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
    ]
  }()
  
  private lazy var feedbackLabelConstraints2: [NSLayoutConstraint] = {
    return [
      feedbackLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
      feedbackLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
      feedbackLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
    ]
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = blue
    view.addSubview(feedbackLabel)
    
    feedbackLabel.translatesAutoresizingMaskIntoConstraints = false
    
    if view.traitCollection.verticalSizeClass == .compact ||
      view.traitCollection.verticalSizeClass == .unspecified {
      NSLayoutConstraint.activate(feedbackLabelConstraints2)
    } else {
      NSLayoutConstraint.activate(feedbackLabelConstraints1)
    }
    
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
  
  override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
    super.willTransition(to: newCollection, with: coordinator)
    if newCollection.verticalSizeClass == .compact {
      NSLayoutConstraint.deactivate(feedbackLabelConstraints1)
      NSLayoutConstraint.activate(feedbackLabelConstraints2)
    } else {
      NSLayoutConstraint.deactivate(feedbackLabelConstraints2)
      NSLayoutConstraint.activate(feedbackLabelConstraints1)
    }
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
