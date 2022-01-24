//
//  AlertAction.swift
//  BioAuthTest
//
//  Created by Ameya Bhagat on 18/01/22.
//

import UIKit


struct AlertAction {
    var title = ""
    var type: UIAlertAction.Style? = .default
    var enable: Bool? = true
    var selected: Bool? = false
    
    init(title: String, type: UIAlertAction.Style? = .default, enable: Bool? = true, selected: Bool? = false) {
        self.title = title
        self.type = type
        self.enable = true
        self.selected = selected
    }
    
}
