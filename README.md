<p align="center">
    <img src="Logo.png" width="480" max-width="90%" alt="Cards" />
</p>

<p align="center">
    <a href="https://travis-ci.org/rob-nash/Cards">
        <img src="https://travis-ci.org/rob-nash/Cards.svg?branch=master" alt="Build" />
    </a>
    <a href="https://twitter.com/nashytitz">
        <img src="https://img.shields.io/badge/contact-@nashytitz-blue.svg?style=flat" alt="Twitter: @nashytitz" />
    </a>
</p>

A dequing menu of card-shaped view controllers.

<p align="left"><img src="http://i.giphy.com/3ohc18V0x9lylBzwsw.gif" width="259" height="460"/></p>

## Usage

Given a data source like the following.

```swift
class DanceClass {
    let name: String
    let address1: String
    let address2: String
    let town: String
    let postcode: String
}
```


Create an instance of `CardsManager` and keep a strong reference to it.

```swift
import UIKit
import Cards

class ViewController: UIViewController {
  
  private lazy var cardsManager: CardsManager<DanceClassViewController> = {
    let danceClasses: [DanceClass] = DanceClassGenerator.fetchClasses()
    let scenes: [DanceClassViewController] = danceClasses.map { danceClass in
      return DanceClassViewController(model: danceClass)
    }
    return CardsManager<DanceClassViewController>(scenes: scenes)
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    cardsManager.dismiss = { [unowned self] in
      self.dismiss(animated: true, completion: nil)
    }
    cardsManager.didSelect = { [unowned self] danceClass in
      print("Current selection is \(danceClass.town)")
    }
  }
  
  @IBAction private func tapGestureRecognized(_ sender: UITapGestureRecognizer) {
    present(cardsManager.selectionsScene, animated: true, completion: nil)
  }
}
```

In the above example `DanceClassViewController` should conform to `CardableScene`. As you can see `DanceClass` is the model for `DanceClassViewController`, so your `CardableScene` implementation should specify this.

```swift
import UIKit
import Cards

class DanceClassViewController: UIViewController, CardableScene {
    
    typealias Model = DanceClass
  
    required init(model: DanceClass) {
      self.danceClass = model
      super.init(nibName: nil, bundle: nil)
    }
  
    var showsNavigationBar: Bool {
      return true
    }
  
    var model: DanceClass {
      return danceClass
    }

    private let danceClass: DanceClass
    
    /// Implement a table view here
}
```

Checkout [DanceClass](https://github.com/rob-nash/DanceClass) for an example implementation.

## Installing

For the latest release, select the [release](https://github.com/rob-nash/cards/releases) tab.

### Carthage:

Add `github "rob-nash/cards"` to your `Cartfile`.
