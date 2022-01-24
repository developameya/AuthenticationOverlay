//
//  BundleExtension.swift
//  BioAuthTest
//
//  Created by Ameya Bhagat on 14/01/22.
//

import Foundation

extension Bundle {
    static func appName() -> String {
        guard let dictionary = Bundle.main.infoDictionary else {
            return ""
        }
        if let version : String = dictionary["CFBundleName"] as? String {
            return version
        } else {
            return ""
        }
    }
}
