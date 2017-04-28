//
//  ViewController.swift
//  Pact-iOS
//
//  Created by matt on 2017-04-28.
//  Copyright © 2017 matt. All rights reserved.
//

import UIKit
import Firebase

class VCHome: UIViewController {

    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue
        
        view.addSubview(scrlv)
        
        setupScrlv()
        
        // refresh control
        let refreshControl = UIRefreshControl()
        let title = NSLocalizedString("Pull To Refresh", comment: "Pull to refresh")
        refreshControl.attributedTitle = NSAttributedString(string: title)
        refreshControl.addTarget(self,
                                 action: #selector(refreshOptions(sender:)),
                                 for: .valueChanged)
        scrlv.refreshControl = refreshControl
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkIfUserIsLoggedIn()
    }
    
    // MARK: - Data
    
    // MARK: - View
    let scrlv: UIScrollView = {
        let scrlv = UIScrollView()
        scrlv.backgroundColor = UIColor.white
        scrlv.translatesAutoresizingMaskIntoConstraints = false
        return scrlv
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let pointsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let projectContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var pointsLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height * 0.35))
        label.textAlignment = .center
        label.text = "0 pts"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 28)
        return label
    }()
    
    func setupScrlv() {
        // need x, y, width and height constraints
        scrlv.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrlv.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrlv.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrlv.topAnchor.constraint(equalTo: view.topAnchor, constant: 64).isActive = true
        
        // content view
        scrlv.addSubview(contentView)
        setupContentView()
    }
    
    func setupContentView() {
        // need x, y, width and height constraints
        contentView.leftAnchor.constraint(equalTo: scrlv.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: scrlv.rightAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrlv.bottomAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrlv.topAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        contentView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -64).isActive = true
        
        contentView.addSubview(pointsContainerView)
        contentView.addSubview(projectContainerView)
        
        setupPointsContainerView()
        setupProjectContainerView()
    }
    
    func setupPointsContainerView() {
        // need x, y, width and height constraints
        pointsContainerView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        pointsContainerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        pointsContainerView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        pointsContainerView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.35).isActive = true
        
        pointsContainerView.addSubview(pointsLabel)

    }
    
    func setupProjectContainerView() {
        // need x, y, width and height constraints
        projectContainerView.topAnchor.constraint(equalTo: pointsContainerView.bottomAnchor).isActive = true
        projectContainerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        projectContainerView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        projectContainerView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.65).isActive = true
    }
    
    // MARK: - Func
    @objc private func refreshOptions(sender: UIRefreshControl) {
        sender.endRefreshing()
        print("refresh working!")
    }
    
    @IBAction func logoutBtnPressed(_ sender: Any) {
        handleLogout()
    }
    
    
    // MARK: - Support
    func checkIfUserIsLoggedIn() {
        if FIRAuth.auth()?.currentUser?.uid == nil {
            print("user not signed in")
            let vcRegister = VCRegister()
            self.present(vcRegister, animated: true, completion: nil)
            //perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }
    }
    
    func handleLogout() {
        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        let vcRegister = VCRegister()
        self.present(vcRegister, animated: true, completion: nil)
    }

}
