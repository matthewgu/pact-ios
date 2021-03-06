//
//  Project.swift
//  Pact-iOS
//
//  Created by matt on 2017-04-29.
//  Copyright © 2017 matt. All rights reserved.
//

import UIKit

class Project {
    
    let buttonColors = [UIColor.buttonGreen, UIColor.buttonRed, UIColor.buttonBlue, UIColor.buttonYellow, UIColor.buttonOrange]
    
    private var _projectNameID: String!
    private var _title: String!
    private var _description: String!
    private var _pointsNeeded: String!
    private var _contributeCount: String!
    private var _projectIconName: String!
    private var _coverImageName: String!
    private var _sponsorImageName: String!
    private var _itemName: String!
    private var _itemVerb: String!
    private var _buttonText: String!
    private var _buttonColorIndex: String!
    
    var projectNameID: String {
        return _projectNameID
    }
    
    var title: String {
        return _title
    }
    
    var description: String {
        return _description
    }
    
    var pointsNeeded: String {
        return _pointsNeeded
    }
    
    var contributeCount: String {
        get {
            return _contributeCount
        }
        set{
            _contributeCount = newValue
        }
    }
    
    var coverImageName: String {
        return _coverImageName
    }
    
    var sponsorImageName: String {
        return _sponsorImageName
    }
    
    var projectIconName: String {
        return _projectIconName
    }
    
    var itemName: String {
        return _itemName
    }
    
    var itemVerb: String {
        return _itemVerb
    }
    
    var buttonText: String {
        return _buttonText
    }
    
    var buttonColorIndex: String {
        return _buttonColorIndex
    }
    
    init(projectNameID: String, title: String, description: String, pointsNeeded: String, contributeCount: String, coverImageName: String, sponsorImageName: String, projectIconName: String, itemName: String, itemVerb: String, buttonText: String, buttonColorIndex: String) {
        _projectNameID = projectNameID
        _title = title
        _description = description
        _pointsNeeded = pointsNeeded
        _contributeCount = contributeCount
        _coverImageName = coverImageName
        _sponsorImageName = sponsorImageName
        _projectIconName = projectIconName
        _itemName = itemName
        _itemVerb = itemVerb
        _buttonText = buttonText
        _buttonColorIndex = buttonColorIndex
    }

}


