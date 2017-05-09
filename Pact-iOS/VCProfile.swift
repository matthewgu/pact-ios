//
//  VCProfile2.swift
//  Pact-iOS
//
//  Created by matt on 2017-05-08.
//  Copyright © 2017 matt. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class VCProfile: UIViewController {

    var projects = [Project]()
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.backgroundBeige
        
        
        view.addSubview(buildWithLabel)
        
        setupBuildWithtLabel()
        
        fetchUser()
        fetchProject(completion: { (true) in
            self.view.addSubview(self.headerView)
            self.view.addSubview(self.statsCardShadowView)
            self.view.addSubview(self.statsCardView)
            self.view.addSubview(self.impactLabel)
            
            self.setupHeaderView()
            self.setupStatsCardView()
            self.setupStatsCardShadowView()
            self.setupImpactLabel()
        })
    }
    

    // MARK: - View
    let navBar: UINavigationBar = {
        let navBar = UINavigationBar()
        let navItem = UINavigationItem(title: "")
        navItem.rightBarButtonItem = UIBarButtonItem(title: "X", style: .plain, target: self, action: #selector(handleDismiss))
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
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor.white
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "matt@gmail.com"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.65)
        return label
    }()
    
    let impactLabel: UILabel = {
        let label = UILabel()
        label.text = "YOUR IMPACT"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textColor = UIColor.textDarkBeige
        return label
    }()
    
    let statsCardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let statsCardShadowView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        view.layer.shadowOpacity = 0.15
        view.layer.shadowRadius = 1
        view.layer.cornerRadius = 10
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let buildWithLabel: UILabel = {
        let label = UILabel()
        label.text = "Pact Beta. Build with ❤️ in Vancouver"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 11)
        label.textColor = UIColor.textDarkBeige
        return label
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
        headerView.addSubview(emailLabel)
        
        setupProfileImageView()
        setupNameLabel()
        setupEmailLabel()
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
    
    func setupEmailLabel() {
        emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
    }
    
    func setupImpactLabel() {
        impactLabel.leftAnchor.constraint(equalTo: statsCardView.leftAnchor).isActive = true
        impactLabel.bottomAnchor.constraint(equalTo: statsCardView.topAnchor, constant: -10).isActive = true
    }
    
    func setupBuildWithtLabel() {
        buildWithLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buildWithLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
    }
    
    func setupStatsCardView() {
        // need x, y, width and height constraints
        statsCardView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35).isActive = true
        statsCardView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.93).isActive = true
        statsCardView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        statsCardView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 45).isActive = true
        
        setupStatsView()
        
    }
    
    func setupStatsCardShadowView() {
        // need x, y, width and height constraints
        statsCardShadowView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35).isActive = true
        statsCardShadowView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.93).isActive = true
        statsCardShadowView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        statsCardShadowView.bottomAnchor.constraint(equalTo: statsCardView.bottomAnchor).isActive = true
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
    
    func fetchUser() {
        let uid = FIRAuth.auth()?.currentUser?.uid
        FIRDatabase.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let name = dictionary["name"] as! String
                let email = dictionary["email"] as! String
                let points = dictionary["points"] as! String
                let pointsContributed = dictionary["pointsContributed"] as! String
                
                self.user = User(name: name, email: email, points: points, pointsContributed: pointsContributed)
                // show pts label only when points is loaded
                self.nameLabel.text = name
                self.emailLabel.text = email
                
            }
        }, withCancel: nil)
    }
    
    func fetchProject(completion: @escaping (Bool) -> ()) {
        let uid = FIRAuth.auth()?.currentUser?.uid
        FIRDatabase.database().reference().child("users").child(uid!).child("projects").observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    if let dict = snap.value as? [String: Any] {
                        if let projectNameID = dict["projectNameID"] as? String, let title = dict["title"] as? String, let description = dict["description"] as? String, let pointsNeeded = dict["pointsNeeded"] as? String, let contributeCount = dict["contributeCount"] as? String, let coverImageName = dict["coverImageName"] as? String, let sponsorImageName = dict["sponsorImageName"] as? String, let projectIconName = dict["projectIconName"] as? String, let itemName = dict["itemName"] as? String, let itemVerb = dict["itemVerb"] as? String, let buttonText = dict["buttonText"] as? String, let buttonColorIndex = dict["buttonColorIndex"] as? String {
                            
                            let project = Project(projectNameID: projectNameID, title: title, description: description, pointsNeeded: pointsNeeded, contributeCount: contributeCount, coverImageName: coverImageName, sponsorImageName: sponsorImageName, projectIconName: projectIconName, itemName: itemName, itemVerb: itemVerb, buttonText: buttonText, buttonColorIndex: buttonColorIndex)
                            self.projects.append(project)
                        }
                    }
                }
            }
            completion(true)
        })
    }
}
