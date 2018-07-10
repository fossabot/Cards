import UIKit
import Cards
import Gradient
import Dequable

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
  
  private let backgroundLabel: UILabel = {
    let view = UILabel()
    view.textColor = .white
    view.textAlignment = .center
    view.font = fontC
    view.text = "Tap"
    return view
  }()
  
  private let feedbackLabel: UILabel = {
    let view = UILabel()
    view.textColor = .white
    view.textAlignment = .center
    view.font = fontA
    view.text = "No Selection"
    return view
  }()
  
  private let cardsManager: CardsManager<DanceClassViewController> = {
    let scenes = DanceClassGenerator.generate().map { danceClass -> DanceClassViewController in
      let controller = DanceClassViewController()
      controller.model = danceClass
      return controller
    }
    return try! CardsManager(scenes: scenes)
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
    view.addSubview(backgroundLabel)
    
    feedbackLabel.translatesAutoresizingMaskIntoConstraints = false
    backgroundLabel.translatesAutoresizingMaskIntoConstraints = false
    
    if view.traitCollection.verticalSizeClass == .compact ||
      view.traitCollection.verticalSizeClass == .unspecified {
      NSLayoutConstraint.activate(feedbackLabelConstraints2)
    } else {
      NSLayoutConstraint.activate(feedbackLabelConstraints1)
    }
    
    NSLayoutConstraint.activate([
      backgroundLabel.topAnchor.constraint(equalTo: view.topAnchor),
      backgroundLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      backgroundLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      backgroundLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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

final class DanceClassViewController: UIViewController {
  
  private let tableView = TableView()
  
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
    tableView.dataSource = self
    view.addSubview(tableView)
    
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
      tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
      ])
  }
}

extension DanceClassViewController: CardableScene {
  
  typealias CardableSceneModel = DanceClass
}

extension DanceClassViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 6
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let dequableTableView: DequeableTableView = (tableView as? DequeableTableView).require(hint: "Must conform to DequeableTableView")
    let cell: TableViewCell = dequableTableView.dequeue(indexPath)
    let row = indexPath.row
    guard row < 6 else {
      fatalError("Only expecting 6 rows")
    }
    guard let danceClass = model else {
      fatalError("Model is missing")
    }
    if row == 0 {
      cell.configure(withTitle: "Name", withSubtitle: danceClass.name)
    } else if row == 1 {
      cell.configure(withTitle: "Type", withSubtitle: danceClass.type.rawValue)
    } else if row == 2 {
      cell.configure(withTitle: "Address 1", withSubtitle: danceClass.address1)
    } else if row == 3 {
      cell.configure(withTitle: "Address 2", withSubtitle: danceClass.address2)
    } else if row == 4 {
      cell.configure(withTitle: "Town", withSubtitle: danceClass.town)
    } else if row == 5 {
      cell.configure(withTitle: "Postcode", withSubtitle: danceClass.postcode)
    }
    return cell
  }
}
