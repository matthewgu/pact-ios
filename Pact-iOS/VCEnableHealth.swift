//
//  VCEnableHealth.swift
//  Pact-iOS
//
//  Created by matt on 2017-04-29.
//  Copyright © 2017 matt. All rights reserved.
//

import UIKit

class VCEnableHealth: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(enableHealthKitButton)
    }
    
    // MARK: - View
    let enableHealthKitButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161, a: 1)
        button.setTitle("Enable", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        return button
    }()

    func setupEnableHealthKitButton() {
        enableHealthKitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        enableHealthKitButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12).isActive = true
        enableHealthKitButton.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        enableHealthKitButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
}
