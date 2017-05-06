//
//  VCConfirm.swift
//  Pact-iOS
//
//  Created by matt on 2017-05-01.
//  Copyright © 2017 matt. All rights reserved.
//

import UIKit
import Firebase
import TransitionTreasury

class VCConfirm: UIViewController {
    
    weak var modalDelegate: ModalViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundBeige
        
        view.addSubview(sentenceLabel)
        view.addSubview(contributeCountLabel)
        view.addSubview(byYouLabel)
        view.addSubview(dismissButton)
        
        setupHeaderView()
        setupSentenceLabel()
        setupcontributeCountLabel()
        setupByYouLabel()
        setupDismissButton()
    }
    
    // MARK: - View

    
    var sentenceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "this is the confirmation sentence"
        //label.backgroundColor = UIColor.black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.white
        return label
    }()
    
    var contributeCountLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.backgroundColor = UIColor.black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 80)
        label.textColor = UIColor.white
        return label
    }()
    
    let byYouLabel: UILabel = {
        let label = UILabel()
        label.text = "by you"
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.backgroundColor = UIColor.black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 40)
        label.textColor = UIColor.white
        return label
    }()
    
    let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.4)
        button.setTitle("DISMISS", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    func setupHeaderView() {
        let v = UIView()
        let vWidth: CGFloat = view.frame.size.width
        let vHeight: CGFloat = view.frame.size.height * 0.4
        v.backgroundColor = UIColor.pactRed
        v.frame = CGRect(x: 0, y: 0, width: vWidth, height: vHeight)
        view.addSubview(v)
        
        //let logo = UIImage(named: "pactLogo.png")
        
    }
    
    func setupSentenceLabel() {
        sentenceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sentenceLabel.bottomAnchor.constraint(equalTo: contributeCountLabel.topAnchor, constant: -40).isActive = true
    }
    
    func setupcontributeCountLabel() {
        contributeCountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        contributeCountLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func setupByYouLabel() {
        byYouLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        byYouLabel.bottomAnchor.constraint(equalTo: contributeCountLabel.bottomAnchor, constant: 70).isActive = true
    }
    
    func setupDismissButton() {
        dismissButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dismissButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -44).isActive = true
        dismissButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -48).isActive = true
        dismissButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
    }

    
    // MARK: - Func
    func handleDismiss() {
        modalDelegate?.modalViewControllerDismiss(callbackData: nil)
        //self.dismiss(animated: true, completion: nil)
    }
}
