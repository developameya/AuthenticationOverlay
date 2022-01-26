# AuthenticationOverlay

AuthenticationOverlay provides a layer of obscurity over your app's content before prompting for touch ID.

**Note:** - Face ID authentication requires user's persmission to be add in info.plist.
```swift
<key>NSFaceIDUsageDescription</key>
<string>This app requires Face ID permission to authenticate using Face recognition.</string>
```

## Features
- Works with Apple Touch ID and Face ID devices.
- Predefined error handling when recognition failed, adapted from the dependacy.
- Can be enabled or disabled within any class. Useful for providing user with option for biometric authentication.

## Requirements
- iOS 14.1 or higher
- Xcode 12.0+
- Swift 5.2+

## Installation

Add package to your project in Xcode using following link:

(https://github.com/developameya/AuthenticationOverlay.git)

## Usage
AuthenticationOverlay depends on `BiometricAuthentication` package created by. `rushisangani`. You can find the original repository here:

 (https://github.com/rushisangani/BiometricAuthentication)

Xcode will automatically download the necessary dependacy once you import the package in your product.

### How to use?
 In your app's SceneDelegate
 
 - import `AuthenticationOverlay'.
 
 ```swift
  import 'AuthenticationOverlay' 
  ```
  - Add `AuthentictionOverlayViewController.shared.insert()` in `sceneWillEnterForeground` and `sceneDidEnterBackground` methods.
  
  ```swift
      func sceneWillEnterForeground(_ scene: UIScene) {
      
        AuthentictionOverlayViewController.shared.insert()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    
        AuthentictionOverlayViewController.shared.insert()
    }
 ```
 

