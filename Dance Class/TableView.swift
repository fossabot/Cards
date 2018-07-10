import UIKit
import Dequable
import Require

final class TableView: UITableView, DequeableTableView {
  
  init() {
    super.init(frame: .zero, style: .plain)
    separatorStyle = .none
    register(cellType: TableViewCell.self, hasXib: true)
    backgroundColor = .clear
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

final class TableViewCell: UITableViewCell, DequeableComponentIdentifiable {
  
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
