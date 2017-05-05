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
        navItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
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
        profileCardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
    }
    
    func setupProfileCardShadowView() {
        // need x, y, width and height constraints
        profileCardShadowView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.9).isActive = true
        profileCardShadowView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9).isActive = true
        profileCardShadowView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileCardShadowView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
    }
    
    // MARK: - Func
    func handleLogout()  {
    
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
