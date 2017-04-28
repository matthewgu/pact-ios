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
        view.backgroundColor = UIColor(r: 61, g: 91, b: 151, a: 1)
        
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
    
    // MARK: - Func
    @objc private func refreshOptions(sender: UIRefreshControl) {
        sender.endRefreshing()
        print("refresh working!")
    }
    
    func setupScrlv() {
        scrlv.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrlv.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrlv.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrlv.topAnchor.constraint(equalTo: view.topAnchor, constant: 64).isActive = true
        
        // content view
        scrlv.addSubview(contentView)
        setupContentView()

    }
    
    func setupContentView() {
        contentView.leftAnchor.constraint(equalTo: scrlv.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: scrlv.rightAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrlv.bottomAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrlv.topAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        contentView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -64).isActive = true
    }
    
    // MARK: - Support
    func checkIfUserIsLoggedIn() {
        if FIRAuth.auth()?.currentUser?.uid == nil {
            print("user not signed in")
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

extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat  ) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
    
}
