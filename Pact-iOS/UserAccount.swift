//
//  UserAccount.swift
//  Pact-iOS
//
//  Created by matt on 2017-04-28.
//  Copyright © 2017 matt. All rights reserved.
//

import UIKit

class UserAccount
{
    static var sharedInstance = UserAccount()
    private init() {} // Singleton
    
    private struct Key {
        static let FromDate = "UserAccount.fromDate"
    }
    
    var fromDate: Double {
        get {
            return StorageUtil.doubleForKey(key: Key.FromDate)
        }
        set {
            _ = StorageUtil.saveDouble(double: newValue, key: Key.FromDate)
        }
    }
}
