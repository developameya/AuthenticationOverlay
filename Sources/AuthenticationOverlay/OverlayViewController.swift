//
//  OverlayView.swift
//  BioAuthTest
//
//  Created by Ameya Bhagat on 12/01/22.
//

import UIKit

//This class creates and displays a view over the active window of the app.
//MARK: - Init
open class OverlayViewController: UIViewController {
    //MARK: - Properties
    ///---------------------
    /// MARK: Public properties
    ///---------------------
    /// By default the overlay will display the BundleName as the app name.
    public var appName: String? = Bundle.appName()
    ///---------------------
    /// MARK: Private Properties
    ///---------------------
    private var enableAuthenticaion: Bool?
    private var keyWindow: UIWindow?
    internal let overlayView = OverlayView()
    var imageURL: NSURL?
    var defaults = UserDefaults.standard
    ///---------------------
    /// MARK: property to store a reference to the undrelying ViewController
    ///---------------------
    var currentViewController: UIViewController?
    init(imageURL: NSURL?) {
            self.imageURL = imageURL
            super.init(nibName: nil, bundle: nil)
        }
    
    // this is a convenient way to create this view controller without a imageURL
        convenience init() {
            self.init(imageURL: nil)
            enableAuthenticaion = getState()
            self.keyWindow = UIApplication.shared.getKeyWindow()
            //store the current rootViewController
            currentViewController = keyWindow?.rootViewController
        }
        
    
    // if this view controller is loaded from a storyboard, imageURL will be nil
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension OverlayViewController {
    /**Inserts the overLay over the first viewController of the app.
     Call this method in `sceneWillEnterForeground` and `sceneDidEnterBackground`methods within your app's `SceneDelegate` to obscure content of the app before authentication.*/
   open func insert() {
       guard let safeEnable = enableAuthenticaion else { fatalError("OverlayViewController | \(#function) Authentication state is not set.") }
       if safeEnable {
           insertViewToKeyWindow()
       }
    }
    
    internal func removeOverlay() {
        if let safeView = keyWindow?.viewWithTag(100) {
            safeView.removeFromSuperview()
            //present the stored ViewController as rootViewController
            keyWindow?.rootViewController = currentViewController
        }
        
    }
    
    private func insertViewToKeyWindow() {
        //Check if the window property is nil
        //TODO: Handle the Error properly
        guard let safeWindow = self.keyWindow else { fatalError("`OverlayViewController` - \(#function) | keyWindow cannot be found. Make sure the OverlayViewController is called in SceneDelegate.") }
        //set `OverlayViewController` as the rootViewController
        safeWindow.rootViewController = self
        //Create and add the overlayView to the OverlayViewController.
        safeWindow.addSubview(overlayView)
        configureOverlayView(safeWindow)
    }

    /** Configure overlayView.  */
    internal func configureOverlayView(_ parentView: UIView) {
        overlayView.isUserInteractionEnabled = true
        overlayView.tag = 100
        overlayView.frame = parentView.bounds
        overlayView.setConstraints()
    }
    
    /// Call `changeState` method from anywhere in your app to change the state of the overlay. For example, in your app's settings you can let user choose whether they want to use biometric authentication.
    /// - Parameter enable: Take a boolean value to enable or disable the overlay.
    open func changeState(enable: Bool?) {
        self.defaults.set(enable, forKey: "stateKey")
    }
    
    internal func getState() -> Bool? {
        let key = "stateKey"
        if self.defaults.object(forKey: key) == nil{
            print("OverlayViewController | \(#function) key is nil.")
            return true 
        } else {
            return self.defaults.bool(forKey: key)
        }
    }
}




