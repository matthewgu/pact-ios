//
//  User.swift
//  Pact-iOS
//
//  Created by matt on 2017-05-01.
//  Copyright © 2017 matt. All rights reserved.
//

import UIKit

class User {
    
    private var _name: String!
    private var _email: String!
    private var _profileImageURL: String!
    private var _points: String!
    private var _pointsContributed: String!
    
    var name: String {
        return _name
    }
    
    var email: String {
        return _email
    }
    
    var profileImageURL: String {
        return _profileImageURL
    }
    
    var points: String {
        get {
            return _points
        }
        set{
            _points = newValue
        }
    }
    
    var pointsContributed: String {
        return _pointsContributed
    }
    
    init(name: String, email: String, points: String, pointsContributed: String, profileImageURL: String) {
        _name = name
        _email = email
        _profileImageURL = profileImageURL
        _points = points
        _pointsContributed = pointsContributed
    }
}
