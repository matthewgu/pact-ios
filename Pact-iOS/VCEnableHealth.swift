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
        view.backgroundColor = UIColor.white
        
        view.addSubview(enableHealthKitButton)
        
        setupEnableHealthKitButton()
    }
    
    // MARK: - View
    let enableHealthKitButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.black
        button.setTitle("Enable", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        button.addTarget(self, action: #selector(handleHealthKitAuth), for: .touchUpInside)
        return button
    }()

    func setupEnableHealthKitButton() {
        enableHealthKitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        enableHealthKitButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        enableHealthKitButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        enableHealthKitButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    // MARK: - Func
    func handleHealthKitAuth() {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
}
