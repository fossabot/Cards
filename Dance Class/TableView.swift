import UIKit
import Dequable
import Require

final class DanceClassTableView: UITableView, DequeableTableView {
  
  init() {
    super.init(frame: .zero, style: .plain)
    separatorStyle = .none
    register(cellType: DanceClassTableViewCell.self, hasXib: true)
    backgroundColor = .clear
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

final class DanceClassTableViewCell: UITableViewCell, DequeableComponentIdentifiable {
  
  @IBOutlet private var labelOne: UILabel! {
    didSet {
      labelOne.font = fontA
      labelOne.textColor = green
    }
  }
  
  @IBOutlet private var dividerView: UIView! {
    didSet {
      dividerView.backgroundColor = pink
    }
  }
  
  @IBOutlet private weak var textField: UITextField! {
    didSet {
      textField.font = fontB
      textField.textColor = green
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

final class DanceClassTableViewModel: NSObject, UITableViewDataSource {
  
  let danceClass: DanceClass
  
  init(danceClass: DanceClass) {
    self.danceClass = danceClass
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 6
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let dequableTableView: DequeableTableView = (tableView as? DequeableTableView).require(hint: "Must conform to DequeableTableView")
    let cell: DanceClassTableViewCell = dequableTableView.dequeue(indexPath)
    let row = indexPath.row
    guard row < 6 else {
      fatalError("Only expecting 6 rows")
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
