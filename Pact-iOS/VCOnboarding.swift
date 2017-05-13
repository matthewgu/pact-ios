//
//  VCOnboarding.swift
//  Pact-iOS
//
//  Created by matt on 2017-05-12.
//  Copyright © 2017 matt. All rights reserved.
//

import UIKit
import paper_onboarding

class VCOnboarding: UIViewController, PaperOnboardingDataSource, PaperOnboardingDelegate {
    
    //@IBOutlet weak var onboardingView: OnboardingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        onboardingView.dataSource = self
        onboardingView.delegate = self
        
        
        view.addSubview(onboardingView)
        view.addSubview(dismissButton)
        
        setupOnboardingVieww()
        setupDismissButton()
        
    }
    
    let onboardingView: OnboardingView = {
        let view = OnboardingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("GET STARTED", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.alpha = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }()
    
    func handleNext() {
        let vcEnableHealth = VCEnableHealth()
        self.present(vcEnableHealth, animated: true, completion: nil)
    }
    
    func setupOnboardingVieww() {
        // need x, y, width and height constraints
        onboardingView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        onboardingView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        onboardingView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        onboardingView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
    
    func setupDismissButton() {
        dismissButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //dismissButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -48).isActive = true
        dismissButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        dismissButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90).isActive = true
    }
    
    func onboardingItemsCount() -> Int {
        return 3
    }
    
    func onboardingItemAtIndex(_ index: Int) -> OnboardingItemInfo {
        let backgroundColorOne = UIColor.buttonGreen
        let backgroundColorTwo = UIColor.buttonBlue
        let backgroundColorThree = UIColor.buttonRed
        
        let descriptionOne =    "Your phone tracks the number of steps your walk & run."
        let descriptionTwo =    "Earn 1 point for every step you take. Walk & run as you would."
        let descriptionThree =  "Use points to make an impact for causes you advocate for."
        
        
        let titleFont = UIFont.boldSystemFont(ofSize: 17)
        let descriptionFont = UIFont.boldSystemFont(ofSize: 14)
        
        return [
            ("track", "TRACK", descriptionOne, "", backgroundColorOne, UIColor.white, UIColor.white, titleFont, descriptionFont),
            ("walk", "WALK", descriptionTwo, "", backgroundColorTwo, UIColor.white, UIColor.white, titleFont, descriptionFont),
            ("impact", "IMPACT", descriptionThree, "", backgroundColorThree, UIColor.white, UIColor.white, titleFont, descriptionFont)
            
            ][index]
    }
    
    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
        
    }
    
    func onboardingWillTransitonToIndex(_ index: Int) {
        if index == 1 {
            if self.dismissButton.alpha == 1 {
                UIView.animate(withDuration: 0.2, animations: {
                    self.dismissButton.alpha = 0
                })
            }
        }
    }
    
    func onboardingDidTransitonToIndex(_ index: Int) {
        if index == 2 {
            UIView.animate(withDuration: 0.3, animations: {
                self.dismissButton.alpha = 1
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
