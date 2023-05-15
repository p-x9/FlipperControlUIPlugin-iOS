# FlipperControlUIPlugin-iOS
Flipper plug-in that can send TouchEvent and Keyboard events from PC to iPhone..(iOS client)
[Desktop Plugin is Here](https://github.com/p-x9/flipper-plugin-control-ui)

<img width="2032" alt="Desktop" src="https://github.com/p-x9/FlipperControlUIPlugin-iOS/assets/50244599/d0388de0-c37d-429e-be5e-5bf4ef45ec29">


## Installation
### CocoaPods
Put the following in your Podfile
```ruby
pod 'FlipperControlUIPlugin', :git => 'https://github.com/p-x9/FlipperControlUIPlugin-iOS.git'
pod 'HammerTests', :git => "https://github.com/p-x9/Hammer.git", :branch => "flipper"
```

### Swift Package
Currently not supported

### Usage
#### Setup for iOS project
For UIKit-made apps, write the following.
```swift
import FlipperKit
import FlipperControlUIPlugin

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene),
              let keyWindow = windowScene.keyWindow else {
                return
        }
        let client = FlipperClient.shared()
        client?.add(FlipperControlUIPlugin(for: keyWindow))
        client?.start()
    }
}
```
If you are using SwiftUI, write as follows.
```swift
@main
struct flipper_testApp: App { // Your Application
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate // use AppDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate, UIWindowSceneDelegate {
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let config = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        config.delegateClass = SceneDelegate.self // use SceneDelegate
        return config
    }
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene),
              let keyWindow = windowScene.keyWindow else {
                return
        }
        let client = FlipperClient.shared()
        client?.add(FlipperControlUIPlugin(for: keyWindow))
        client?.start()
    }
}
```

#### Send Touch event and Keyboard Event with Flipper
1. Download Flipper App to your PC.
    [Flipper's GitHub Page is Here](https://github.com/facebook/flipper)
    [Flipper Document Page is Here](https://fbflipper.com)

    In the case of Mac, the
    Homebrew can be used for easy installation.
    ```bash
    brew install flipper
    ```
2. install flipper-plugin-control-ui (plugin for PC)
   [p-x9/flipper-plugin-control-ui](https://github.com/p-x9/flipper-plugin-control-ui)
   Please download the PC plug-in from the release section of the Github page below.
   Once downloaded, install the software from the Flipper application.

3. Connect iPhone to PC and launch application
   If the connection is successful, a section called 'Control UI' will be added to the left side tab.
   Check it as it may be in the 'Disabled' section.

4. Use


## License

FlipperControlUIPlugin-iOS is released under the MIT License. See [LICENSE](./LICENSE)
