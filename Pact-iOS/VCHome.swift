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
import PageControls
import TransitionTreasury
import TransitionAnimation

class VCHome: UIViewController, VProjectDelegate, ModalTransitionDelegate {
    
    var tr_presentTransition: TRViewControllerTransitionDelegate?
    
    // firebase ref
    var ref: FIRDatabaseReference?
    
    // userdata data
    var projects = [Project]()
    var user: User?
    
    // horizonta scroll view
    let scrlv = UIScrollView()
    @IBOutlet weak var snakePageControl: SnakePageControl!
    
    // refresh control
    let refresh = UIRefreshControl()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        JTSplashView.splashViewWithBackgroundColor(nil, circleColor: nil, circleSize: nil)
        
        // Simulate state when we want to hide the splash view
        Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(VCHome.hideSplashView), userInfo: nil, repeats: false)
        
        // TODO: need to avoid loading duplicate projects
        // self.projects.removeAll()
        self.checkIfUserIsLoggedIn()
        
        scrlv.isPagingEnabled = true
        scrlv.delegate = self
        
        // view related
        view.backgroundColor = UIColor.gray
        view.addSubview(scrollView)
        view.addSubview(navBar)
        
        setupScrlv()
        setupNavBar()
        
        // refresh control
        refresh.tintColor = UIColor.clear
        refresh.backgroundColor = UIColor.clear
        refresh.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        //loadRefreshControl()
        scrollView.refreshControl = refresh
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }

    // MARK: - Data
    func getStep() {
        // Check Authorization
        HealthKitUtil.shared.checkAuthorization { (authorized) in
            
            if authorized
            {
                // get step
                HealthKitUtil.shared.getStep(completion: { (success, newSteps) in
                    if success
                    {
                        // get past steps and new steps
                        DispatchQueue.main.async {
                            
                            // add steups
                            self.addPoints(steps: newSteps)
                            
                            // save steps
                            UserAccount.shared.totalSteps += newSteps
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

    func addPoints(steps: Int) {
        var oldPoints = Int()
        if let oldPointsOptional = Int((self.user?.points)!) {
            oldPoints = oldPointsOptional
        }
        let currentPoints = oldPoints + steps
        let currentPointsStr = "\(currentPoints)"
        
        // update points
        self.user?.points = currentPointsStr
        ref = FIRDatabase.database().reference()
        let uid = FIRAuth.auth()?.currentUser?.uid
        self.ref?.child("users/\(uid!)/points").setValue(currentPointsStr)
        
        _ = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { (Timer) in
            // end refresh
            self.refresh.endRefreshing()
        })
        
        // animate points label after 1.7 s
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
            // animate points
            if currentPoints != oldPoints {
                self.countingLabel(start: oldPoints, end: currentPoints)
                self.pointsLabel.text = self.user?.points
            }
        }
    }
    
    func fetchPoints(completion: @escaping (Bool) -> ()) {
        let uid = FIRAuth.auth()?.currentUser?.uid
        FIRDatabase.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                if let points = dictionary["points"] as? String {
                    self.user?.points = points
                }
            }
        completion(true)
        }, withCancel: nil)
    }
    
    func fetchContriuteCount(project: Project, completion: @escaping (Bool) -> ()) {
        let uid = FIRAuth.auth()?.currentUser?.uid
            FIRDatabase.database().reference().child("users").child(uid!).child("projects").child(project.projectNameID).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                if let contributeCount = dictionary["contributeCount"] as? String {
                    project.contributeCount = contributeCount
                }
            }
            completion(true)
        })
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
                self.ptsLabel.text = "pts"
                self.pointsLabel.text = points
                
            }
        }, withCancel: nil)
    }
    
    func fetchProject(completion: @escaping (Bool) -> ()) {
        let uid = FIRAuth.auth()?.currentUser?.uid
        FIRDatabase.database().reference().child("users").child(uid!).child("projects").observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    if let dict = snap.value as? [String: Any] {
                        if let projectNameID = dict["projectNameID"] as? String, let title = dict["title"] as? String, let description = dict["description"] as? String, let pointsNeeded = dict["pointsNeeded"] as? String, let contributeCount = dict["contributeCount"] as? String, let coverImageName = dict["coverImageName"] as? String, let sponsorImageName = dict["sponsorImageName"] as? String, let itemName = dict["itemName"] as? String, let itemVerb = dict["itemVerb"] as? String, let buttonText = dict["buttonText"] as? String {
                            
                            let project = Project(projectNameID: projectNameID, title: title, description: description, pointsNeeded: pointsNeeded, contributeCount: contributeCount, coverImageName: coverImageName, sponsorImageName: sponsorImageName, itemName: itemName, itemVerb: itemVerb, buttonText: buttonText)
                
                            self.projects.append(project)
                        }
                    }
                }
            }
            completion(true)
        })
    }
    
    func handleProjectContribution(project: Project) {
        IJProgressView.shared.showProgressView(view)
        var currentPoints = Int()
        var pointsNeeded = Int()
        var contributeCount = Int()
        var pointsContributed =  Int()
        
        if let currentPointsOptional = Int((user?.points)!), let pointsNeededOptional = Int(project.pointsNeeded), let contributeCountOptional = Int(project.contributeCount), let pointsContributedOptional = Int((user?.pointsContributed)!)  {
            currentPoints = currentPointsOptional
            pointsNeeded = pointsNeededOptional
            contributeCount = contributeCountOptional
            pointsContributed = pointsContributedOptional
        }
        
        if currentPoints >= pointsNeeded {
            // setting new values
            let newPoints = currentPoints - pointsNeeded
            contributeCount = contributeCount + 1
            pointsContributed = pointsContributed + pointsNeeded
            
            // converting to string
            let newPointsString = "\(newPoints)"
            let contributeCountString = "\(contributeCount)"
            let pointsContributedString = "\(pointsContributed)"
            
            // updating new values
            self.user?.points = pointsContributedString
            
            ref = FIRDatabase.database().reference()
            let uid = FIRAuth.auth()?.currentUser?.uid
            self.ref?.child("users/\(uid!)/points").setValue(newPointsString)
            self.ref?.child("users/\(uid!)/pointsContributed").setValue(pointsContributedString)
            self.ref?.child("users/\(uid!)/projects/\(project.projectNameID)/contributeCount/").setValue(contributeCountString)
            
            // pull new data
            fetchUser()
            fetchContriuteCount(project: project, completion: { (true) in
                _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (Timer) in
                    IJProgressView.shared.hideProgressView()
                    
                    let vcConfirm = VCConfirm()
                    vcConfirm.modalDelegate = self // Don't forget to set modalDelegate
                    vcConfirm.sentenceLabel.text = "We planted 122 trees together!"
                    vcConfirm.contributeCountLabel.text = project.contributeCount
                    self.tr_presentViewController(vcConfirm, method: TRPresentTransitionMethod.twitter, completion: nil)
                })
            })
            
            print("Project Title: \(project.title), Contribute Count: \(project.contributeCount) \(project.itemName), Points Contributed: \(user?.pointsContributed ?? "0") points")
            
        } else {
            IJProgressView.shared.hideProgressView()
            // not enough points
            let alert = UIAlertController(title: "Not Enough Points", message: "Try Again", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - View
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
        scrlv.backgroundColor = UIColor(red: 250/255, green: 248/255, blue: 246/255, alpha: 1)
        scrlv.translatesAutoresizingMaskIntoConstraints = false
        return scrlv
    }()
    
    let contentView: UIView = {
        let view = UIView()
        //view.backgroundColor = UIColor.gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let pointsContainerView: UIStackView = {
        let view = UIStackView()
        //view.backgroundColor = UIColor.red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let pointsStackView: UIStackView = {
        let sView = UIStackView()
        //sView.backgroundColor = UIColor.blue
        sView.translatesAutoresizingMaskIntoConstraints = false
        return sView
    }()
    
    let ptsLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = UIColor.orange
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.black
        return label
    }()
    
    let pointsSeparatorView: UIView = {
        let view = UIView()
        //view.backgroundColor = UIColor.black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let pointsLabel: CountingLabel = {
        let label = CountingLabel()
        //label.backgroundColor = UIColor.blue
        label.textAlignment = .right
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 70)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupNavBar() {
        navBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        navBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        navBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        navBar.heightAnchor.constraint(equalToConstant: 64).isActive = true
    }
    
    func setupPagingView() {
        // Scroll View
        let scrlvHeight: CGFloat = ((self.view.frame.size.height - 64) * 0.65)
        scrlv.frame = CGRect(x: 0, y: (self.view.frame.size.height - 64 - scrlvHeight), width: self.view.frame.size.width, height: scrlvHeight)
        scrlv.bounces = true
        scrlv.isScrollEnabled = true
        self.contentView.addSubview(scrlv)
        
        // page control
        if projects.count > 1 {
            scrlv.addSubview(snakePageControl)
            snakePageControl.pageCount = projects.count
            snakePageControl.indicatorPadding = 15
            snakePageControl.indicatorRadius = 6
            snakePageControl.activeTint = UIColor(red: 8/255, green: 37/255, blue: 78/255, alpha: 1)
            snakePageControl.inactiveTint = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1)
        }
    
        var x = 0 as CGFloat
        for i in 0..<projects.count
        {
            // base view
            let v = UIView()
            //v.backgroundColor = getRandomColor()
            v.frame = CGRect(x: x, y: 0, width: self.view.frame.size.width, height: scrlvHeight)
            scrlv.addSubview(v)
            
            // shawdow view
            let shadowView = UIView()
            shadowView.backgroundColor = UIColor.white
            
            shadowView.layer.masksToBounds = false

            shadowView.layer.cornerRadius = 10
            shadowView.layer.shadowColor = UIColor.black.cgColor
            shadowView.layer.shadowOffset = CGSize(width: 0.0, height: 10.0)
            shadowView.layer.shadowOpacity = 0.25
            shadowView.layer.shadowRadius = 10
            
            v.addSubview(shadowView)
            shadowView.frame = CGRect(x: 18 + 5, y: 40, width: (v.frame.size.width) - 36 - 10, height: (v.frame.size.height) - 66)
            
            // project view
            if let project = UINib(nibName: "CustomView", bundle: nil).instantiate(withOwner: self, options: nil).first as? VProject {
                project.delegate = self
                project.layer.cornerRadius = 10
                project.layer.masksToBounds = true
                let projectDetails: Project = projects[i]
                project.updateProjectView(project: projectDetails)
                v.addSubview(project)
                project.frame = CGRect(x: 18, y: 40, width: (v.frame.size.width) - 36, height: (v.frame.size.height) - 66)
            }
            
            // Adjust size
            x = v.frame.maxX
            scrlv.contentSize.width = x
        }
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
        
        contentView.addSubview(pointsContainerView)
        setupPointsContainerView()
    }
    
    func setupPointsContainerView() {
    
        pointsContainerView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        pointsContainerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        pointsContainerView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        pointsContainerView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.35).isActive = true
        
        pointsContainerView.addSubview(pointsStackView)
        setupPointsStackView()
    }
    
    func setupPointsStackView() {
        pointsStackView.centerYAnchor.constraint(equalTo: pointsContainerView.centerYAnchor).isActive = true
        pointsStackView.centerXAnchor.constraint(equalTo: pointsContainerView.centerXAnchor).isActive = true
        
        pointsStackView.addArrangedSubview(pointsLabel)
        pointsStackView.addArrangedSubview(pointsSeparatorView)
        pointsStackView.addArrangedSubview(ptsLabel)
        
        setupPointsSeparatorView()
    }
    
    func setupPointsSeparatorView() {
        pointsSeparatorView.widthAnchor.constraint(equalToConstant: 8).isActive = true
    }
    
    // MARK: - Func
    
    func handleRefresh() {
        loadRefreshControl()
        fetchPoints { (true) in
            self.getStep()
        }
    }
    
    func countingLabel(start: Int, end: Int) {
        pointsLabel.count(fromValue: Float(start), to: Float(end), withDuration: 2.4, andAnimationType: .EaseOut, andCouterType: .Int)
    }
    
    func checkIfUserIsLoggedIn() {
        if FIRAuth.auth()?.currentUser?.uid == nil {
            print("user not signed in")
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        } else {
            fetchUser()
            fetchProject(completion: { (true) in
                self.setupPagingView()
            })
        }
        
    }
    
    func tappedContributeBtn(project: Project) {
        // TODO: Pull user and project data before
        handleProjectContribution(project: project)
    }
    
    // MARK: - Support
    func hideSplashView() {
        JTSplashView.finishWithCompletion { () -> Void in
            UIApplication.shared.isStatusBarHidden = false
        }
    }
    
    func loadRefreshControl() {
        let refreshContents = UINib(nibName: "VRefresh", bundle: nil).instantiate(withOwner: self, options: nil)
        
        let customView = refreshContents[0] as! UIView
        
        customView.frame = refresh.bounds
        customView.backgroundColor = UIColor.clear
        
        let customLabel = customView.viewWithTag(1) as! UILabel
        customLabel.textColor = UIColor.white
        
        UIView.animate(withDuration: 0.5 , delay: 0, options: [.autoreverse, .curveLinear, .repeat], animations: {
            customView.backgroundColor = UIColor.orange
            customView.backgroundColor = UIColor.black
        }, completion: nil)
        
        self.refresh.addSubview(customView)
    }
    
    func handleLogout() {
        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }
        self.present(VCRegister(), animated: true, completion: nil)
    }

}

extension VCHome: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrlv: UIScrollView) {
        let page = scrlv.contentOffset.x / scrlv.bounds.width
        let progressInPage = scrlv.contentOffset.x - (page * scrlv.bounds.width)
        let progress = CGFloat(page) + progressInPage
        snakePageControl.progress = progress
    }
}

