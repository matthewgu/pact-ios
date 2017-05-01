//
//  Project.swift
//  Pact-iOS
//
//  Created by matt on 2017-04-29.
//  Copyright © 2017 matt. All rights reserved.
//

import UIKit

class Project {
    
    private var _projectNameID: String!
    private var _title: String!
    private var _description: String!
    private var _pointsNeeded: String!
    private var _contributeCount: String!
    private var _coverImageName: String!
    private var _sponsorImageName: String!
    private var _itemName: String!
    private var _buttonText: String!
    private var _buttonColour: UIColor = UIColor.blue
    
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
        return _contributeCount
    }
    
    var coverImageName: String {
        return _coverImageName
    }
    
    var sponsorImageName: String {
        return _sponsorImageName
    }
    
    var itemName: String {
        return _itemName
    }
    
    var buttonText: String {
        return _buttonText
    }
    
    var buttonColour: UIColor {
        return _buttonColour
    }
    
    init(projectNameID: String, title: String, description: String, pointsNeeded: String, contributeCount: String, coverImageName: String, sponsorImageName: String, itemName: String, buttonText: String) {
        _projectNameID = projectNameID
        _title = title
        _description = description
        _pointsNeeded = pointsNeeded
        _contributeCount = contributeCount
        _coverImageName = coverImageName
        _sponsorImageName = sponsorImageName
        _itemName = itemName
        _buttonText = buttonText
    }
}


