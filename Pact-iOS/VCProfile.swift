//
//  VCProfile.swift
//  Pact-iOS
//
//  Created by matt on 2017-05-05.
//  Copyright © 2017 matt. All rights reserved.
//

import UIKit

class VCProfile: UIViewController {

    // refresh control
    let refresh = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // view related
        view.backgroundColor = UIColor.white
        view.addSubview(redView)
        view.addSubview(scrollView)
        view.addSubview(navBar)
        
        setupRedView()
        setupScrlv()
        setupNavBar()
        
        // refresh control
        refresh.tintColor = UIColor.clear
        refresh.backgroundColor = UIColor.clear
        refresh.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        scrollView.refreshControl = refresh
    }
    
    // MARK: - View
    let redView: UIScrollView = {
        let scrlv = UIScrollView()
        scrlv.backgroundColor = UIColor.pactRed
        scrlv.translatesAutoresizingMaskIntoConstraints = false
        return scrlv
    }()
    
    let navBar: UINavigationBar = {
        let navBar = UINavigationBar()
        let navItem = UINavigationItem(title: "Pact")
        navItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        navItem.rightBarButtonItem = UIBarButtonItem(title: "Dismiss", style: .plain, target: self, action: #selector(handleDismiss))
        navBar.setItems([navItem], animated: false)
        navBar.translatesAutoresizingMaskIntoConstraints = false
        return navBar
    }()
    
    let scrollView: UIScrollView = {
        let scrlv = UIScrollView()
        scrlv.backgroundColor = UIColor.clear
        scrlv.translatesAutoresizingMaskIntoConstraints = false
        return scrlv
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let profileCardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let profileCardShadowView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 10.0)
        view.layer.shadowOpacity = 0.25
        view.layer.shadowRadius = 10
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
        label.text = "Rahul Jiresal"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.black
        return label
    }()
    
    let statsView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setupRedView() {
        // need x, y, width and height constraints
        redView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6).isActive = true
        redView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        redView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        redView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setupNavBar() {
        navBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        navBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        navBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        navBar.heightAnchor.constraint(equalToConstant: 64).isActive = true
    }
    
    func setupScrlv() {
        // need x, y, width and height constraints
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 64).isActive = true
        
        // content view
        scrollView.addSubview(contentView)
        setupContentView()
    }
    
    func setupContentView() {
        // need x, y, width and height constraints
        contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        contentView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -64).isActive = true
        
        contentView.addSubview(profileCardShadowView)
        contentView.addSubview(profileCardView)
        setupProfileCardShadowView()
        setupProfileCardView()
    }
    
    func setupProfileCardView() {
        // need x, y, width and height constraints
        profileCardView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.9).isActive = true
        profileCardView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9).isActive = true
        profileCardView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileCardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50).isActive = true
        
        profileCardView.addSubview(profileImageView)
        profileCardView.addSubview(nameLabel)
        
        setupProfileImageView()
        setupNameLabel()
        setupStatsView()
    }
    
    func setupProfileCardShadowView() {
        // need x, y, width and height constraints
        profileCardShadowView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8).isActive = true
        profileCardShadowView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9).isActive = true
        profileCardShadowView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileCardShadowView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50).isActive = true
    }
    
    func setupProfileImageView() {
        // need x, y, width and height constraints
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.topAnchor.constraint(equalTo: profileCardView.topAnchor, constant: 30).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    func setupNameLabel() {
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 30).isActive = true
    }
    
    func setupStatsView() {
        profileCardView.addSubview(statsView)
        statsView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        statsView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 30).isActive = true
        statsView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        statsView.widthAnchor.constraint(equalTo: profileCardView.widthAnchor, multiplier: 0.9).isActive = true

    }
    
    // MARK: - Func
    func handleLogout()  {
    
    }
    
    func handleDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func handleRefresh() {
        loadRefreshControl()
        self.refresh.endRefreshing()

    }
    
    // MARK: - Support
    func loadRefreshControl() {
        let refreshContents = UINib(nibName: "VRefresh", bundle: nil).instantiate(withOwner: self, options: nil)
        
        let customView = refreshContents[0] as! UIView
        
        customView.frame = refresh.bounds
        customView.backgroundColor = UIColor.clear
        
        let customLabel = customView.viewWithTag(1) as! UILabel
        customLabel.text = ""
        customLabel.backgroundColor = UIColor.clear
        
        self.refresh.addSubview(customView)
    }

}
