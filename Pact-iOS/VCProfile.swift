//
//  VCProfile2.swift
//  Pact-iOS
//
//  Created by matt on 2017-05-08.
//  Copyright © 2017 matt. All rights reserved.
//

import UIKit

class VCProfile: UIViewController {

    var projects = [Project]()
    
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
        let navItem = UINavigationItem(title: "")
        navItem.rightBarButtonItem = UIBarButtonItem(title: "Dismiss", style: .plain, target: self, action: #selector(handleDismiss))
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
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profileImage.png")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Matthew Gu"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.white
        return label
    }()
    
    let statsCardView: UIView = {
        let view = UIView()
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
        
        headerView.addSubview(profileImageView)
        headerView.addSubview(nameLabel)
        
        setupProfileImageView()
        setupNameLabel()
    }
    
    func setupProfileImageView() {
        // need x, y, width and height constraints
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 65).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func setupNameLabel() {
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 15).isActive = true
    }
    
    func setupStatsCardView() {
        // need x, y, width and height constraints
        statsCardView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35).isActive = true
        statsCardView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.93).isActive = true
        statsCardView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        statsCardView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 45).isActive = true
        
        setupStatsView()
        
    }
    
    func setupStatsView() {
        let v = UIView()
        v.backgroundColor = UIColor.white
        let vWidth: CGFloat = view.frame.size.width * 0.93
        v.frame = CGRect(x: 0, y: 0, width: vWidth, height: view.frame.size.height)
        statsCardView.addSubview(v)
        
        for i in 0..<projects.count {
            if let statsView = UINib(nibName: "Stats", bundle: nil).instantiate(withOwner: self, options: nil).first as? VStats {
                
                v.addSubview(statsView)
                let projectDetails: Project = projects[i]
                statsView.statsLabel.textColor = UIColor.textDarkGrey
                statsView.updateStatsView(project: projectDetails)
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
