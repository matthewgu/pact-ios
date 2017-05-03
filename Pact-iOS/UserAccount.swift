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
    static var shared = UserAccount()
    private init() {} // Singleton
    
    private struct Key {
        static let TotalSteps = "UserAccount.TotalSteps"
        static let PreviousSteps = "UserAccount.PreviousSteps"
        static let PreviousFromDate = "UserAccount.PreviousFromDate"
        static let PreviousToDate = "UserAccount.PreviousToDate"
        static let PreviousStatisticEndDate = "UserAccount.PreviousStatisticsEndDate"
    }
    
    var totalSteps: Int {
        get {
            return StorageUtil.intForKey(key: Key.TotalSteps)
        }
        set {
            _ = StorageUtil.saveInt(int: newValue, key: Key.TotalSteps)
        }
    }
    
    var previousSteps: Int {
        get {
            return StorageUtil.intForKey(key: Key.PreviousSteps)
        }
        set {
            _ = StorageUtil.saveInt(int: newValue, key: Key.PreviousSteps)
        }
    }
    
    var previousFromDate: Double {
        get {
            return StorageUtil.doubleForKey(key: Key.PreviousFromDate)
        }
        set {
            _ = StorageUtil.saveDouble(double: newValue, key: Key.PreviousFromDate)
        }
    }
    
    var previousToDate: Double {
        get {
            return StorageUtil.doubleForKey(key: Key.PreviousToDate)
        }
        set {
            _ = StorageUtil.saveDouble(double: newValue, key: Key.PreviousToDate)
        }
    }
    
    var previousStatisticsEndDate: Double {
        get {
            return StorageUtil.doubleForKey(key: Key.PreviousStatisticEndDate)
        }
        set {
            _ = StorageUtil.saveDouble(double: newValue, key: Key.PreviousStatisticEndDate)
        }
    }
}
