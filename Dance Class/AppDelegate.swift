import UIKit

let red = #colorLiteral(red: 0.8705882353, green: 0.4196078431, blue: 0.2823529412, alpha: 1)
let green = #colorLiteral(red: 0.8549019608, green: 0.9294117647, blue: 0.7411764706, alpha: 1)
let blue = #colorLiteral(red: 0.4901960784, green: 0.7333333333, blue: 0.7647058824, alpha: 1)
let brown = #colorLiteral(red: 0.8980392157, green: 0.6941176471, blue: 0.5058823529, alpha: 1)
let pink = #colorLiteral(red: 0.9568627451, green: 0.7254901961, blue: 0.6980392157, alpha: 1)

let fontA = UIFont(name: "AvenirNext-DemiBold", size: UIDevice.current.userInterfaceIdiom == .pad ? 40.0 : 20.0)!
let fontB = UIFont(name: "AvenirNext-Regular", size: UIDevice.current.userInterfaceIdiom == .pad ? 40.0 : 20.0)!

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    UINavigationBar.appearance().tintColor = green
    UINavigationBar.appearance().barTintColor = red
    return true
  }

}
