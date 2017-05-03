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
        button.backgroundColor = UIColor(red: 183/255, green: 56/255, blue: 42/255, alpha: 1)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        button.addTarget(self, action: #selector(handleHealthKitAuth), for: .touchUpInside)
        return button
    }()
    
    func setupEnableHealthKitButton() {
        enableHealthKitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        enableHealthKitButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -44).isActive = true
        enableHealthKitButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -48).isActive = true
        enableHealthKitButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
    }
    
    // MARK: - Func
    func handleHealthKitAuth() {
        
        // Check Authorization
        HealthKitUtil.shared.checkAuthorization { (authorized) in
            
            if authorized
            {
                DispatchQueue.main.async {
                    // go to VCHome
                    print("Authorized")
                    self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                }
            }
            else
            {
                DispatchQueue.main.async {
                    print("Not authorized")
                }
            }
        }
        
    }
    
}
