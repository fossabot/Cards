import UIKit
import Dequable

class DanceClassTableView: UITableView, DequeableTableView {
    
    init(style: UITableViewStyle) {
        super.init(frame: .zero, style: style)
        separatorStyle = .none
        register(cellType: DanceClassTableViewCell.self, hasXib: true)
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
