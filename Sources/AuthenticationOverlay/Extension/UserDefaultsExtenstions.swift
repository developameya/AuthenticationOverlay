//
//  UserDefaultsExtenstions.swift
//  BioAuthTest
//
//  Created by Ameya Bhagat on 06/01/22.
//

import Foundation

extension UserDefaults {

private var biometricAuth: String {
    return String("biometricAuth")
}

func setAuthKey (_ isAuthenticated: Bool) {
    set(isAuthenticated, forKey: biometricAuth)
}

func getAuthKey() -> Bool {
    bool(forKey: biometricAuth)
}
}
