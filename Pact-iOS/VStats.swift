//
//  VStats.swift
//  Pact-iOS
//
//  Created by matt on 2017-05-06.
//  Copyright © 2017 matt. All rights reserved.
//

import UIKit

class VStats: UIView {

    @IBOutlet weak var projectIcon: UIImageView!
    @IBOutlet weak var statsLabel: UILabel!
    
    func updateStatsView(project: Project) {
        //stats label
        statsLabel.font = UIFont.boldSystemFont(ofSize: 14)
        
        // images
        projectIcon.layer.masksToBounds = true
    }
    
}
