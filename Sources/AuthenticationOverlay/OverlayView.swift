//
//  BackgroundView.swift
//  BioAuthTest
//
//  Created by Ameya Bhagat on 13/01/22.
//

import UIKit

public class OverlayView: TranslucentEffectView {
    //MARK: - Properties
    private let stackView = TextStackView.shared
    //MARK: - Init
    override init(effect: UIVisualEffect?) {
        super.init(effect: effect)
        print("`OverlayView` intialised.")
        self.contentView.addSubview(stackView)
        stackView.setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /** This method calls function to update the UI as the system theme change  */
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        switch traitCollection.userInterfaceStyle {
        case .unspecified:
            refreshView(with: .black)
        case .light:
            refreshView(with: .black)
        case .dark:
            refreshView(with: .white)
        @unknown default:
            refreshView(with: .black)
        }
    }
    
    func refreshView(with colour: UIColor) {
        stackView.foregroundColour = colour
        stackView.layoutSubviews()
    }

}

//MARK: - Layout methods
extension OverlayView {
    /** Set constraints of the current view with respect to it's parent View. */
    func setConstraints() {
        guard let safeSuperView = self.superview else { fatalError("`OverlayView` - \(#function) | superView is not set. Please check the call stack in the superView.") }
        self.translatesAutoresizingMaskIntoConstraints                              = false
        self.topAnchor.constraint(equalTo: safeSuperView.topAnchor).isActive           = true
        self.bottomAnchor.constraint(equalTo: safeSuperView.bottomAnchor).isActive     = true
        self.leadingAnchor.constraint(equalTo: safeSuperView.leadingAnchor).isActive   = true
        self.trailingAnchor.constraint(equalTo: safeSuperView.trailingAnchor).isActive = true
    }
}

