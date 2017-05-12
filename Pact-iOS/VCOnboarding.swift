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
        button.setTitle("DISMISS", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 8
        button.alpha = 0
        button.backgroundColor = UIColor.green
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }()
    
    func handleNext() {
        print("handle next")
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
        dismissButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -48).isActive = true
        dismissButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        dismissButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -44).isActive = true
    }
    
    func onboardingItemsCount() -> Int {
        return 3
    }
    
    func onboardingItemAtIndex(_ index: Int) -> OnboardingItemInfo {
        let backgroundColorOne = UIColor.red
        let backgroundColorTwo = UIColor.blue
        let backgroundColorThree = UIColor.purple
        
        let titleFont = UIFont.systemFont(ofSize: 15)
        let descriptionFont = UIFont.systemFont(ofSize: 12)
        
        return [
            ("rocket", "this is a title", "this is a description", "", backgroundColorOne, UIColor.white, UIColor.white, titleFont, descriptionFont),
            ("brush", "this is a title", "this is a description", "", backgroundColorTwo, UIColor.white, UIColor.white, titleFont, descriptionFont),
            ("notification", "this is a title", "this is a description", "", backgroundColorThree, UIColor.white, UIColor.white, titleFont, descriptionFont)
            
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
            UIView.animate(withDuration: 0.4, animations: {
                self.dismissButton.alpha = 1
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
