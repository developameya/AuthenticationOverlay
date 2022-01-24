//
//  UIApplicationExtension.swift
//  BioAuthTest
//
//  Created by Ameya Bhagat on 13/01/22.
//

import UIKit

extension UIApplication {
    
    /**Getting the key window. */
    func getKeyWindow() -> UIWindow? {

        struct Static {
            //This will cache the key window
            static weak var keyWindow: UIWindow?
        }
        var originalKeyWindow: UIWindow? = nil

        #if swift(>=5.1)
        if #available(iOS 13, *) {
            originalKeyWindow = self.connectedScenes
                .compactMap{ $0 as? UIWindowScene }
                .flatMap{$0.windows}
                .first(where: {$0.isKeyWindow})
        } else {
            originalKeyWindow = self.keyWindow
        }
        #else
        originalKeyWindow = self.keyWindow
        #endif

        //If original key window is not nil and the cached keywindow is also not original keywindow then changing keywindow.
        if let originalKeyWindow = originalKeyWindow {
            Static.keyWindow = originalKeyWindow
        }
        return Static.keyWindow
    }
}
