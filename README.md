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
    <a href="https://codebeat.co/projects/github-com-rob-nash-cards-master">
        <img alt="codebeat badge" src="https://codebeat.co/badges/a474c194-4584-41d2-9931-071ea43428d9" />
    </a>
    <a href="https://swift.org">
        <img src="https://img.shields.io/badge/swift-4.1-green.svg?style=flat" alt="Swift: 4.1" />
    </a>
    <a href="https://developer.apple.com">
        <img src="https://img.shields.io/badge/xcode-9+-green.svg?style=flat" alt="Xcode: 9+" />
    </a>
</p>

A dequing menu of card-shaped view controllers.

<p align="left"><img src="http://i.giphy.com/3ohc18V0x9lylBzwsw.gif" width="259" height="460"/></p>

## Usage

```swift
import UIKit
import Cards

class ViewController: UIViewController {
    
  private let cardsManager: CardsManager<DanceClassViewController> = {
    let controllers = DanceClassGenerator.generate().map { danceClass -> DanceClassViewController in
      let controller = DanceClassViewController()
      controller.model = danceClass
      return controller
    }
    return try! CardsManager(scenes: controllers)
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    cardsManager.dismiss = { [unowned self] in
        self.dismiss(animated: true, completion: nil)
    }
    cardsManager.didSelect = { [unowned self] danceClass in
        print("Current selection is \(danceClass.town)")
    }
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognized(_:)))
    view.addGestureRecognizer(tapGesture)
  }
  
  @objc func tapGestureRecognized(_ sender: UITapGestureRecognizer) {
    present(cardsManager.selectionsScene, animated: true, completion: nil)
  }
}
```

The above `DanceClassViewController` conforms to `CardableScene`.

* [CardableScene](https://github.com/rob-nash/Cards/wiki/CardableScene).
* [DanceClassGenerator](https://github.com/rob-nash/Cards/wiki/DanceClassGenerator)

## Demo

Run the [Carthage](https://github.com/Carthage/Carthage) command `carthage bootstrap`. Then Run the scheme `DanceClass`.

## Installing

For the latest release, select the [release](https://github.com/rob-nash/cards/releases) tab.

### Carthage:

Add `github "rob-nash/cards"` to your `Cartfile`.
