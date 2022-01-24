//
//  AuthenticationOverlay.swift
//  BioAuthTest
//
//  Created by Ameya Bhagat on 14/01/22.
//

import UIKit
import BiometricAuthentication

typealias AlertController = UIAlertController
/**`AuthenticationOverlayDelegate`  provides methods to execute actions to it's delegate calller based on the authentication result */
public protocol AuthenticationOverlayDelegate {
    //FIXME: These methods do not work as of now. The work is currently handled by `isAuthenticated` bool.
    func autheticationSuccess()
    func authenticaionFailure()
}

/**`AuthentictionOverlay` sublclasses `Overlay` class and adds methods to listen and respond to biometric authentication result.
 */
open class AuthentictionOverlayViewController: OverlayViewController {
    //MARK: - Public properties
    /**
     Returns the default singleton instance.
     */
    public static let shared  = AuthentictionOverlayViewController()
    public var delegate:AuthenticationOverlayDelegate?
    public var isAuthenticated = false
    //MARK: - private properties
    private let CancelTitle =  "Cancel"
    private let OKTitle = "OK"
    
    
    override init(imageURL: NSURL?) {
        super.init(imageURL: imageURL)
        TextStackView.shared.delegate = self
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.authenticate()
    }
    
    func authenticate() {
        //FIXME: This does not work, the overlay should only appear and ask for authentication if it's enabled with `enableAuthentication`.
        BioMetricAuthenticator.authenticateWithBioMetrics(reason: "") { [self] (result) in
            switch result {
            case .success(_):
                self.defaults.setAuthKey(true)
                self.isAuthenticated = self.defaults.getAuthKey()
                self.removeOverlay()
                self.delegate?.autheticationSuccess()
            case .failure(let error):
                switch error {
                case .canceledByUser, .canceledBySystem:
                    break
                case .passcodeNotSet:
                    // go to passcode settings
                    self.showSettingsAlert(message: error.message())
                case .biometryNotAvailable:
                    // show passcode authentication
                    self.showPasscodeAuthetication(message: error.message())
                case .biometryNotEnrolled:
                    //go to biometry settings
                    self.showSettingsAlert(message: error.message())
                case .biometryLockedout:
                    //Biometry is locked out due to too many failed attempts. Display passcode authentication.
                    self.showPasscodeAuthetication(message: error.message())
                default:
                    self.delegate?.authenticaionFailure()
                }
            }
        }
    }
}

//MARK: - Authetication Alerts
extension AuthentictionOverlayViewController {
    func showSettingsAlert(message: String) {
        let settingsAction = AlertAction(title: "Go to Settings")
        
        let alertViewController = getAlertController(style: .alert, with: "Error", message: message, actions: [settingsAction], showCancel: false) { buttonText in
            if buttonText == self.CancelTitle { return }
            
            //open settings
            let url = URL(string: UIApplication.openSettingsURLString)
            if UIApplication.shared.canOpenURL(url!) {
                UIApplication.shared.open(url!, options: [:])
            }
        }
        
        present(alertViewController, animated: true, completion: nil)
    }
    
    func showPasscodeAuthetication(message: String) {
        BioMetricAuthenticator.authenticateWithPasscode(reason: message) { [weak self] (result) in
            switch result {
            case .success(_):
                self?.defaults.setAuthKey(true)
                self?.isAuthenticated = self?.defaults.getAuthKey() ?? false
                self?.removeOverlay()
                self?.delegate?.autheticationSuccess()
            case .failure(let error):
                print(error.message())
                self?.delegate?.authenticaionFailure()
            }
        }
    }
    
    func getAlertController(
        style: AlertController.Style,
        with title: String?,
        message: String?,
        actions: [AlertAction],
        showCancel: Bool,
        actionHandler: @escaping ((_ title: String) -> ())) -> AlertController {
            
            let alertController = AlertController(title: title, message: message, preferredStyle: style)
            //items
            var actionItems: [UIAlertAction] = []
            //add actions
            for (index, action) in actions.enumerated() {
                let actionButton = UIAlertAction(title: action.title, style: action.type!) { (actionButton) in
                    actionHandler(actionButton.title ?? "")
                }
                actionButton.isEnabled = action.enable!
                if style == .actionSheet {
                    actionButton.setValue(action.selected, forKey: "checked")
                }
                
                actionButton.setAssociated(object: index)
                
                actionItems.append(actionButton)
                alertController.addAction(actionButton)
            }
            
            // add cancel button
            if showCancel {
                let cancelAction = UIAlertAction(title: CancelTitle, style: .cancel, handler: { (action) in
                    actionHandler(action.title!)
                })
                alertController.addAction(cancelAction)
            }
            return alertController
    }
    
}

//MARK: - TextStackViewDelegate methods
extension AuthentictionOverlayViewController: TextStackViewDelegate {
    func buttonAction(_ sender: UIButton) {
        self.authenticate()
    }
}

//MARK: - AuthenticationOverlayDelegate extension
extension AuthenticationOverlayDelegate {
    func autheticationSuccess() {
        
    }
    func authenticaionFailure() {
        
    }
}



