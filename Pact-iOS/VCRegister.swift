//
//  VCRegister.swift
//  Pact-iOS
//
//  Created by matt on 2017-04-28.
//  Copyright © 2017 matt. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import Mixpanel

class VCRegister: UIViewController {
    
    var ref: FIRDatabaseReference?
    var inputsContainerViewHeigthAnchor: NSLayoutConstraint?
    var nameTextFieldTopAnchor: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.pactRed
        
        view.addSubview(logoView)
        view.addSubview(inputsContainerView)
        view.addSubview(loginRegisterButton)
        view.addSubview(loginRegisterSegmentedControl)
        
        setupLogoView()
        setupinputsContainerView()
        setuploginRegisterButton()
        setuploginRegisterSegmentedControl()
    }
    
    // MARK: - Model
    let firstProjectNameID = "serveMeal"
    let firstProject = ["projectNameID": "serveMeal", "title": "Help Union Gospel Mission Serve a Meal", "description": "UGM works in the areas of poverty, homelessness, and addiction in Vancouver, serving over 300k meals and provided 28k shelter beds in 2016 year alone.", "pointsNeeded": "3000", "contributeCount": "0", "coverImageName": "serveMeal.jpg", "sponsorImageName": "telus.png", "itemName": "meals", "itemVerb": "served", "buttonText": "SERVE A MEAL", "buttonColorIndex": "1", "projectIconName": "serveMealIcon.png"]
    
    // MARK: - View
    let logoView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pactLogo.png")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let inputsContainerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name"
        tf.backgroundColor = UIColor.white
        tf.layer.cornerRadius = 8
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = .systemFont(ofSize: 14)
        return tf
    }()
    
    let nameView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = UIColor.white
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.backgroundColor = UIColor.white
        tf.layer.cornerRadius = 8
        tf.layer.masksToBounds = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = .systemFont(ofSize: 14)
        return tf
    }()
    
    let emailView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = UIColor.white
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.backgroundColor = UIColor.white
        tf.layer.cornerRadius = 8
        tf.isSecureTextEntry = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = .systemFont(ofSize: 14)
        return tf
    }()
    
    let passwordView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = UIColor.white
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let loginRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.buttonRedDark
        button.setTitle("REGISTER", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        button.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
        return button
    }()
    
    func setupLogoView() {
        // need x, y, width and height constraints
        logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 110).isActive = true
        logoView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -110).isActive = true
        logoView.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func setupinputsContainerView() {
        // need x, y, width and height constraints
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.bottomAnchor.constraint(equalTo: loginRegisterButton.topAnchor, constant: -25).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -48).isActive = true
        inputsContainerViewHeigthAnchor = inputsContainerView.heightAnchor.constraint(equalToConstant: 185)
        inputsContainerViewHeigthAnchor?.isActive = true
        
        inputsContainerView.addSubview(nameView)
        inputsContainerView.addSubview(nameTextField)
        inputsContainerView.addSubview(emailView)
        inputsContainerView.addSubview(emailTextField)
        inputsContainerView.addSubview(passwordView)
        inputsContainerView.addSubview(passwordTextField)
        
        //Name Text Field
        nameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 14).isActive = true
        nameTextField.bottomAnchor.constraint(equalTo: emailTextField.topAnchor, constant: -10).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, constant: -14).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        //Name View
        nameView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        nameView.bottomAnchor.constraint(equalTo: emailTextField.topAnchor, constant: -10).isActive = true
        nameView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameView.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        //Email Text Field
        emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 14).isActive = true
        emailTextField.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -10).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, constant: -14).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        //Email View
        emailView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        emailView.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -10).isActive = true
        emailView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailView.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        //Password Text Field
        passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 14).isActive = true
        passwordTextField.bottomAnchor.constraint(equalTo: inputsContainerView.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, constant: -14).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        //Password View
        passwordView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        passwordView.bottomAnchor.constraint(equalTo: inputsContainerView.bottomAnchor).isActive = true
        passwordView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, constant: -14).isActive = true
        passwordView.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
    }
    
    func setuploginRegisterButton() {
        loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        // enable login button bottom anchor adjustment
        var logintButtonBottomAnchor = loginRegisterButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -44)
        logintButtonBottomAnchor.isActive = true
        if DeviceUtil.height <= CGFloat(568.0) {
            logintButtonBottomAnchor.isActive = false
            logintButtonBottomAnchor = loginRegisterButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
            logintButtonBottomAnchor.isActive = true
        }
        
    }
    
    lazy var loginRegisterSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["LOGIN", "REGISTER"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = UIColor.white
        sc.selectedSegmentIndex = 1
        sc.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
        return sc
    }()
    
    func handleLoginRegisterChange() {
        let title = loginRegisterSegmentedControl.titleForSegment(at: loginRegisterSegmentedControl.selectedSegmentIndex)
        loginRegisterButton.setTitle(title, for: .normal)
        
        // change height of input container view
        inputsContainerViewHeigthAnchor?.constant = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 120 : 185
    }
    
    func setuploginRegisterSegmentedControl() {
        loginRegisterSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterSegmentedControl.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -12).isActive = true
        loginRegisterSegmentedControl.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, multiplier: 1).isActive = true
        loginRegisterSegmentedControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }

    // MARK: - Func
    func handleLoginRegister() {
        IJProgressView.shared.showProgressView(view)
        if loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
            handleLogin()
        } else {
            handleRegister()
        }
    }
    
    func handleLogin() {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            print("form is not valid")
            IJProgressView.shared.hideProgressView()
            return
        }
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                print(error as Any)
                // TODO: proper login error message
                let alert = UIAlertController(title: "Ops!", message: "wrong email or password", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                IJProgressView.shared.hideProgressView()
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            self.present(VCEnableHealth(), animated: true, completion: nil)
            self.nameTextField.text = ""
            self.emailTextField.text = ""
            self.passwordTextField.text = ""
            print("User successfully logged in")
            
        })
    }
    
    func handleRegister() {
        
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text else {
            
            print("form is not valid")
            
            IJProgressView.shared.hideProgressView()
            return
        }
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user:FIRUser?, error) in
            if error != nil {
                print(error as Any)
                // TODO: proper register error message
                let alert = UIAlertController(title: "Ops!", message: "email is already taken", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                IJProgressView.shared.hideProgressView()
                return
            }
            guard let uid = user?.uid else {
                return
            }
            
            //successfully authenticated user
            self.ref = FIRDatabase.database().reference()
            let userReference = self.ref?.child("users").child(uid)
            let values = ["name": name, "email": email, "points": "0", "pointsContributed": "0", "profileImageName": "nil"] as [String : Any]
            userReference?.updateChildValues(values, withCompletionBlock: { (err, ref) in
                if err != nil {
                    print(err as Any)
                    return
                }
                
                let values = [self.firstProjectNameID: self.firstProject]
                userReference?.child("projects").updateChildValues(values, withCompletionBlock: { (err, ref) in
                    if err != nil {
                        print(err as Any)
                        return
                    }
                    // mixpanel
                    let mixpanelID = email
                    Mixpanel.mainInstance().identify(distinctId: mixpanelID)
                    Mixpanel.mainInstance().people.set(property: "$name",
                                                       to: name)
                    Mixpanel.mainInstance().people.set(property: "$email",
                                                       to: email)
                    
                    IJProgressView.shared.hideProgressView()
                    self.present(VCEnableHealth(), animated: true, completion: nil)
                    self.nameTextField.text = ""
                    self.emailTextField.text = ""
                    self.passwordTextField.text = ""
                    print("User successfully saved into Firebase DB")
                })
            })
        })
    }
    
    // MARK: - Support
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat  ) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
    
}


