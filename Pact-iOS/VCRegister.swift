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

class VCRegister: UIViewController {
    
    var ref: FIRDatabaseReference?
    var inputsContainerViewHeigthAnchor: NSLayoutConstraint?
    var nameTextFieldTopAnchor: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(r: 61, g: 91, b: 151, a: 1)
        view.addSubview(scrlv)
        setupScrlv()

    }
    
    // MARK: - Model
    let firstProjectNameID = "sendMeal"
    let firstProject = Project(title: "Help Union Gospel Mission  Serve a Meal", description: "UGM works in the areas of poverty, homelessness, and addiction in Vancouver, serving over 300k meals and provided 28k shelter beds in 2016 year alone.", pointsNeeded: "3000", contributeCount: "0", coverImageName: "sendMealCover", sponsorImageName: "telus", itemName: "meals", buttonText: "SERVE A MEAL")
    
    // MARK: - View
    let scrlv: UIScrollView = {
        let scrlv = UIScrollView()
        scrlv.backgroundColor = UIColor.white
        scrlv.translatesAutoresizingMaskIntoConstraints = false
        return scrlv
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 61, g: 91, b: 151, a: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setupScrlv() {
        scrlv.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrlv.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrlv.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrlv.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
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
        contentView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        contentView.addSubview(inputsContainerView)
        contentView.addSubview(loginRegisterButton)
        contentView.addSubview(loginRegisterSegmentedControl)

        setupinputsContainerView()
        setuploginRegisterButton()
        setuploginRegisterSegmentedControl()
    }
    
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = .systemFont(ofSize: 14)
        return tf
    }()
    
    let nameSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 200, a: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = .systemFont(ofSize: 14)
        return tf
    }()
    
    let emailSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 200, a: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = .systemFont(ofSize: 14)
        return tf
    }()
    
    let loginRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161, a: 1)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        button.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
        return button
    }()
    
    func setupinputsContainerView() {
        // need x, y, width and height constraints
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputsContainerViewHeigthAnchor = inputsContainerView.heightAnchor.constraint(equalToConstant: 150)
        inputsContainerViewHeigthAnchor?.isActive = true
        
        inputsContainerView.addSubview(nameTextField)
        inputsContainerView.addSubview(nameSeparatorView)
        inputsContainerView.addSubview(emailTextField)
        inputsContainerView.addSubview(emailSeparatorView)
        inputsContainerView.addSubview(passwordTextField)
        
        //Name Text Field
        nameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        nameTextFieldTopAnchor = nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: 0)
        nameTextFieldTopAnchor?.isActive = true
        
        nameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        //Name Separator View
        nameSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        nameSeparatorView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        
        nameSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        //Email Text Field
        emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        
        emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //Email Separator View
        emailSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        
        emailSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        //Password Text Field
        passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        
        passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    func setuploginRegisterButton() {
        loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterButton.topAnchor.constraint(lessThanOrEqualTo: inputsContainerView.bottomAnchor, constant: 12).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    lazy var loginRegisterSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Login", "Register"])
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
        inputsContainerViewHeigthAnchor?.constant = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 100 : 150
        
        
        // change top anchor of nameTextField
        nameTextFieldTopAnchor?.isActive = false
        nameTextFieldTopAnchor = nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? -50 : 0)
        nameTextField.isHidden = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? true : false
        nameTextFieldTopAnchor?.isActive = true
    }
    
    func setuploginRegisterSegmentedControl() {
        loginRegisterSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterSegmentedControl.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -12).isActive = true
        loginRegisterSegmentedControl.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, multiplier: 1).isActive = true
        loginRegisterSegmentedControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }

    // MARK: - Func
    func handleLoginRegister() {
        if loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
            handleLogin()
        } else {
            handleRegister()
        }
    }
    
    func handleLogin() {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            print("form is not valid")
            return
        }
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                print(error as Any)
                return
            }
            
            self.dismiss(animated: true, completion: nil)
            self.nameTextField.text = ""
            self.emailTextField.text = ""
            self.passwordTextField.text = ""
            print("User successfully logged in")
            
        })
    }
    
    func handleRegister() {
        
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text else {
            print("form is not valid")
            return
        }
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user:FIRUser?, error) in
            if error != nil {
                print(error as Any)
                return
            }
            guard let uid = user?.uid else {
                return
            }
            
            //successfully authenticated user
            self.ref = FIRDatabase.database().reference()
            let userReference = self.ref?.child("users:").child(uid)
            let values = ["name": name, "email": email ]
            userReference?.updateChildValues(values, withCompletionBlock: { (err, ref) in
                if err != nil {
                    print(err as Any)
                    return
                }
                self.dismiss(animated: true, completion: nil)
                self.nameTextField.text = ""
                self.emailTextField.text = ""
                self.passwordTextField.text = ""
                print("User successfully saved into Firebase DB")
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
