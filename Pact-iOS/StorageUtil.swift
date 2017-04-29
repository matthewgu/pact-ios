//
//  StorageUtil.swift
//  Pact-iOS
//
//  Created by matt on 2017-04-28.
//  Copyright © 2017 matt. All rights reserved.
//

import UIKit

class StorageUtil
{
    static let ud = UserDefaults.standard
    
    // String
    static func saveStr(str: String, key: String) -> Bool
    {
        ud.set(str, forKey: key)
        return ud.synchronize()
    }
    
    static func strForKey(key: String) -> String
    {
        if let value = ud.string(forKey: key) {
            return value
        } else {
            return ""
        }
    }
    
    // Int
    static func saveInt(int: Int, key: String) -> Bool
    {
        ud.set(int, forKey: key)
        return ud.synchronize()
    }
    
    static func intForKey(key: String) -> Int
    {
        return ud.integer(forKey: key)
    }
    
    // Double
    static func saveDouble(double: Double, key: String) -> Bool
    {
        ud.set(double, forKey: key)
        return ud.synchronize()
    }
    
    static func doubleForKey(key: String) -> Double
    {
        return ud.double(forKey: key)
    }
    
    // Bool
    static func saveBl(bl: Bool, key: String) -> Bool
    {
        ud.set(bl, forKey: key)
        return ud.synchronize()
    }
    
    static func boolForKey(key: String) -> Bool
    {
        return ud.bool(forKey: key)
    }
    
    // Object
    static func saveObj(obj: AnyObject, key: String) -> Bool {
        ud.set(obj, forKey: key)
        return ud.synchronize()
    }
    
    static func objForKey(key: String) -> AnyObject? {
        return ud.object(forKey: key) as AnyObject?
    }
    
    // Object (NSData)
    static func objectForKey(key: String) -> AnyObject? {
        return ud.object(forKey: key) as AnyObject?
    }
    
    static func saveObject(object: AnyObject, key: String) -> Bool {
        ud.set(object, forKey: key)
        return ud.synchronize()
    }
    
    // Delete User Defaults data
    static func resetUserAccount()
    {
        let dictionary = ud.dictionaryRepresentation()
        for (key, _) in dictionary {
            ud.removeObject(forKey: key)
        }
        ud.synchronize()
    }
    
    // Support
    static func isKeychainAvailable() -> Bool
    {
        return TARGET_IPHONE_SIMULATOR != 1
    }
}
