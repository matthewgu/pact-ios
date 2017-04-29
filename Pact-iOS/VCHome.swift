//
//  ViewController.swift
//  Pact-iOS
//
//  Created by matt on 2017-04-28.
//  Copyright © 2017 matt. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class VCHome: UIViewController {
    
    // firebase ref
    var ref: FIRDatabaseReference?
    
    var projects = [Project]()
    
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        
        // view related
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
    func getStep()
    {
        // Check Authorization
        HealthKitUtil.sharedInstance.checkAuthorization { (authorized) in
            
            if authorized
            {
                // Get step
                HealthKitUtil.sharedInstance.getStep(completion: { (success, totalSteps) in
                    if success
                    {
                        // Get past steps and new steps
                        DispatchQueue.main.async {
                            self.addPoints(steps: totalSteps)
                            print("total steps: " + "\(totalSteps)")
                            print("---------------------------------")
                        }
                    }
                    else
                    {
                        DispatchQueue.main.async {
                            print("Failed to get steps")
                        }
                    }
                })
            }
            else
            {
                DispatchQueue.main.async {
                    print("Not authorized")
                }
            }
        }
    }
    
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
    
    let pointsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    func addProjectView() {
        if let project = UINib(nibName: "CustomView", bundle: nil).instantiate(withOwner: self, options: nil).first as? ProjectView {
            
            project.translatesAutoresizingMaskIntoConstraints = false
            self.projectContainerView.addSubview(project)
            
            // need x, y, width and height constraints
            project.leadingAnchor.constraint(equalTo: projectContainerView.leadingAnchor, constant: 15).isActive = true
            project.trailingAnchor.constraint(equalTo: projectContainerView.trailingAnchor, constant: -15).isActive = true
            project.heightAnchor.constraint(equalToConstant: projectHeightConstraintConstant()).isActive = true
            project.bottomAnchor.constraint(equalTo: projectContainerView.bottomAnchor, constant: -18).isActive = true
        }
    }
    
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
        
        setupPointsLabel()
    }
    
    func setupProjectContainerView() {
        // need x, y, width and height constraints
        projectContainerView.topAnchor.constraint(equalTo: pointsContainerView.bottomAnchor).isActive = true
        projectContainerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        projectContainerView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        projectContainerView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.65).isActive = true
        
        addProjectView()
    }
    
    func setupPointsLabel() {
        // need x, y, width and height constraints
        pointsLabel.centerYAnchor.constraint(equalTo: pointsContainerView.centerYAnchor).isActive = true
        pointsLabel.centerXAnchor.constraint(equalTo: pointsContainerView.centerXAnchor).isActive = true
        pointsLabel.widthAnchor.constraint(equalTo: pointsContainerView.widthAnchor).isActive = true
        pointsLabel.heightAnchor.constraint(equalTo: pointsContainerView.heightAnchor).isActive = true
    }
    
    // MARK: - Func
    @objc private func refreshOptions(sender: UIRefreshControl) {
        sender.endRefreshing()
        getStep()
        fetchPoints()
    }
    
    func checkIfUserIsLoggedIn() {
        if FIRAuth.auth()?.currentUser?.uid == nil {
            print("user not signed in")
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        } else {
            fetchPoints()
            fetchProject(completion: { (true) in
                print(self.projects[0].description)
            })
        }
        
    }
    
    func fetchPoints() {
        let uid = FIRAuth.auth()?.currentUser?.uid
        FIRDatabase.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                self.pointsLabel.text = dictionary["points"] as? String
            }
            
        }, withCancel: nil)
    }
    
    func addPoints(steps: Int) {
        let currentPointsStr = "\(steps)"
        ref = FIRDatabase.database().reference()
        let uid = FIRAuth.auth()?.currentUser?.uid
        self.ref?.child("users/\(uid!)/points").setValue(currentPointsStr)
    }
    
    func fetchProject(completion: @escaping (Bool) -> ()) {
        let uid = FIRAuth.auth()?.currentUser?.uid
        FIRDatabase.database().reference().child("users").child(uid!).child("projects").observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    if let dict = snap.value as? [String: Any] {
                        if let title = dict["title"] as? String, let description = dict["description"] as? String, let pointsNeeded = dict["pointsNeeded"] as? String, let contributeCount = dict["contributeCount"] as? String, let coverImageName = dict["coverImageName"] as? String, let sponsorImageName = dict["sponsorImageName"] as? String, let itemName = dict["itemName"] as? String, let buttonText = dict["buttonText"] as? String {
                            
                            let project = Project(title: title, description: description, pointsNeeded: pointsNeeded, contributeCount: contributeCount, coverImageName: coverImageName, sponsorImageName: sponsorImageName, itemName: itemName, buttonText: buttonText)
                            
                            self.projects.append(project)
                        }
                    }
                }
            }
            completion(true)
        })
    }
    
    @IBAction func logoutBtnPressed(_ sender: Any) {
        handleLogout()
    }
    
    // MARK: - Support
    
    func handleLogout() {
        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }
        self.present(VCRegister(), animated: true, completion: nil)
    }
    
    //   Project View Height constraint based on device screen height
    func projectHeightConstraintConstant() -> CGFloat {
        switch(UIScreen.main.fixedCoordinateSpace.bounds.height) {
        case 568:
            return 300
        default:
            return 340
        }
    }

}
