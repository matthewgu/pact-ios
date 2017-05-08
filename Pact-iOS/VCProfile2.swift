//
//  VCProfile2.swift
//  Pact-iOS
//
//  Created by matt on 2017-05-08.
//  Copyright © 2017 matt. All rights reserved.
//

import UIKit

class VCProfile2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.backgroundBeige
        
        view.addSubview(headerView)
        view.addSubview(navBar)
        view.addSubview(statsCardView)
        
        setupHeaderView()
        setupNavBar()
        setupStatsCardView()

    }
    

    // MARK: - View
    let navBar: UINavigationBar = {
        let navBar = UINavigationBar()
        let navItem = UINavigationItem(title: "Pact")
        navItem.rightBarButtonItem = UIBarButtonItem(title: "Profile", style: .plain, target: self, action: #selector(handleDismiss))
        navBar.tintColor = UIColor.white
        navBar.isTranslucent = false
        navBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default) // set border to transparent
        navBar.shadowImage = UIImage()
        navBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        navBar.barTintColor = UIColor.pactRed
        navBar.setItems([navItem], animated: false)
        navBar.translatesAutoresizingMaskIntoConstraints = false
        return navBar
    }()
    
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.pactRed
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let statsCardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.green
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setupNavBar() {
        navBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        navBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        navBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        navBar.heightAnchor.constraint(equalToConstant: 64).isActive = true
    }
    
    func setupHeaderView() {
        headerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        headerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35).isActive = true
        headerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
    
    func setupStatsCardView() {
        // need x, y, width and height constraints
        statsCardView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35).isActive = true
        statsCardView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.93).isActive = true
        statsCardView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        statsCardView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        
        setupStatsView()
        
    }
    
    func setupStatsView() {
        let v = UIView()
        v.backgroundColor = UIColor.red
        let vWidth: CGFloat = view.frame.size.width * 0.93
        v.frame = CGRect(x: 0, y: 0, width: vWidth, height: view.frame.size.height)
        statsCardView.addSubview(v)
        
        for i in 0..<3 {
            if let statsView = UINib(nibName: "Stats", bundle: nil).instantiate(withOwner: self, options: nil).first as? VStats {
                statsView.backgroundColor = UIColor.blue
                v.addSubview(statsView)
                //let projectDetails: Project = projects[i]
                //statsView.updateStatsView(project: projectDetails)
                statsView.frame = CGRect(x: 15, y: 20 + (CGFloat(i)*60), width: vWidth - 30, height: 40)
            }
        }
    }
    
    // MARK: - Func
    func handleDismiss() {
        //modalDelegate?.modalViewControllerDismiss(callbackData: nil)
        self.dismiss(animated: true, completion: nil)
    }
}
