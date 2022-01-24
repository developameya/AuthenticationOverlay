///**
/**
BioAuthTest
Created by: Ameya Bhagat on 19/01/22
StackView | 

+-----------------------------------------------------------------------------------+
| Permission is hereby granted, free of charge, to any person obtaining a copy  	
| of this software and associated documentation files (the "Software"), to deal	
| in the Software without restriction, including without limitation the rights	
| to use, copy, modify, merge, publish, distribute, sublicense, and/or sell		
| copies of the Software, and to permit persons to whom the Software is		
| furnished to do so, subject to the following conditions:				
|											
| The above copyright notice and this permission notice shall be included in		
| all copies or substantial portions of the Software.					
|											
| THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR		
| IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,		
| FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE	
| AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER		
| LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,	
| OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN		
| THE SOFTWARE.	
									
+-----------------------------------------------------------------------------------+
*/

import UIKit
import BiometricAuthentication
protocol TextStackViewDelegate {
    func buttonAction(_ sender: UIButton)
}

class TextStackView: UIStackView {
    ///---------------------
    /// MARK: Singleton to ensure one instance of the object is initated.
    ///---------------------
    static let shared = TextStackView()
    //MARK: - properties
    ///---------------------
    /// MARK: Public Properties
    ///---------------------
    var delegate:TextStackViewDelegate?
    /**Change the colour of the elements on the stackView. */
    //TODO: - Set these properties from the topmost class.
    open var foregroundColour = UIColor()
    public var appName: String? = Bundle.appName()
    public var title: String?
    public var message: String?
    ///---------------------
    /// MARK: Private properties
    ///---------------------
    private var imageView = UIImageView()
    
    private var titleLabel = UILabel()
    
    private var messageLabel = UILabel()
    
    private var button = UIButton()
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        foregroundColour = UIScreen.main.traitCollection.userInterfaceStyle == .dark ? .white : .black
        configureStackProperties()
        layoutSubviews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - public methods
extension TextStackView {
    public func setTitle() {
        self.addArrangedSubview(titleLabel)
        titleLabel.text = title ?? "\(appName ?? "app") is locked"
        titleLabel.font = .systemFont(ofSize: 32, weight: .bold)
        titleLabel.textColor = foregroundColour
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
    }
    
    public func setMessage() {
        self.addArrangedSubview(messageLabel)
        let biometric: String? = BioMetricAuthenticator.shared.faceIDAvailable() ? "face ID" : "touch ID"
        messageLabel.text = message ?? "Please unlock \(appName ?? "the app") with \(biometric ?? "Biometrics")"
        messageLabel.font = .systemFont(ofSize: 28)
        messageLabel.textColor = foregroundColour
        messageLabel.textAlignment = .center
        messageLabel.adjustsFontSizeToFitWidth = true
    }
    
    public func setButtonTitle() {
        self.addArrangedSubview(button)
        let biometric: String? = BioMetricAuthenticator.shared.faceIDAvailable() ? "face ID" : "touch ID"
        button.setTitle("Use \(biometric ?? "Biometrics")", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        delegate?.buttonAction(sender)
    }
    
    public func setSystemImage(named name: String) -> UIImage? {
         UIImage(configuredSystemImage: name)
    }
    
    public func configureImageView() {
        self.addArrangedSubview(imageView)
        //TODO: - Make this image customisable
        imageView.image = setSystemImage(named: "lock.fill")?.withTintColor(foregroundColour, renderingMode: .alwaysOriginal)
        imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.contentMode = .scaleAspectFit
    }
}

//MARK: - layout methods
extension TextStackView {
    /**Sets the constraints of the View with respect to its parentView. */
    override func layoutSubviews() {
        super.layoutSubviews()
        //TODO: - add subviews
        configureImageView()
        setTitle()
        setMessage()
        setButtonTitle()
    }
    
    final func configureStackProperties() {
        self.axis = .vertical
        self.distribution = .equalSpacing
        self.spacing = 10
        self.autoresizesSubviews = false
    }
    
    
    final func setConstraints() {
        //TODO: - Handle this error gracefully
        guard let safeSuperView = self.superview else { fatalError("`TextStackView` - \(#function) | superView is not set. Please check the call stack.") }
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: safeSuperView.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: safeSuperView.centerYAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: safeSuperView.leadingAnchor, constant: 20).isActive = true
        self.trailingAnchor.constraint(equalTo: safeSuperView.trailingAnchor, constant: -20).isActive = true
    }
}
