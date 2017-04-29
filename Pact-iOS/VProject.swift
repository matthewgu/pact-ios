//
//  ProjectView.swift
//  Pact-iOS
//
//  Created by matt on 2017-04-29.
//  Copyright © 2017 matt. All rights reserved.
//

import UIKit
protocol VProjectDelegate: class {
    func tappedContributeBtn()
}


class VProject: UIView {
    
    var delegate: VProjectDelegate?
    
    @IBOutlet weak var pointsNeededLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var sponsorImage: UIImageView!
    
    @IBOutlet weak var contributeButton: UIButton!
    
    @IBAction func contributeBtnPressed(_ sender: Any) {
        delegate?.tappedContributeBtn()
    }
    

}
