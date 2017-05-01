//
//  VCConfirmation.swift
//  Pact-iOS
//
//  Created by matt on 2017-05-01.
//  Copyright © 2017 matt. All rights reserved.
//

import UIKit

class VCConfirmation: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.brown
        
        view.addSubview(dismissButton)
        
        setupDismissButton()
    }
    
    // MARK: - View
    let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.black
        button.setTitle("Enable", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    func setupDismissButton() {
        dismissButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dismissButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        dismissButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        dismissButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    // MARK: - Func
    func handleDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
}
