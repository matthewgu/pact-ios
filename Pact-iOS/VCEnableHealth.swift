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
        view.backgroundColor = UIColor.backgroundBeige
        
        view.addSubview(enableHealthKitButton)
        view.addSubview(appleHealthLogo)
        view.addSubview(sentenceLabel)
        
        setupEnableHealthKitButton()
        setupSentenceLabel()
        setupAppleHealthLogo()
    }
    
    // MARK: - View
    let appleHealthLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "appleHealth.png")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var sentenceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let attributedString = NSMutableAttributedString(string: "Pact allows your to earn points by walking. You need to first allow Pact to read your fitness data from Apple Health")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 14
        attributedString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        label.attributedText = attributedString
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.darkGray
        return label
    }()
    
    let enableHealthKitButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.buttonRed
        button.setTitle("CONNECT TO APPLE HEALTH", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        button.addTarget(self, action: #selector(handleHealthKitAuth), for: .touchUpInside)
        return button
    }()
    
    
    func setupAppleHealthLogo() {
        // need x, y, width and height constraints
        appleHealthLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        appleHealthLogo.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -130).isActive = true
        appleHealthLogo.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
        //appleHealthLogo.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    func setupSentenceLabel() {
        sentenceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sentenceLabel.topAnchor.constraint(equalTo: appleHealthLogo.bottomAnchor, constant: 60).isActive = true
        sentenceLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95).isActive = true
    }
    
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
