//
//  VCConfirm.swift
//  Pact-iOS
//
//  Created by matt on 2017-05-01.
//  Copyright © 2017 matt. All rights reserved.
//

import UIKit

class VCConfirm: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1)
        
        
        view.addSubview(confirmImageView)
        view.addSubview(sentenceLabel)
        view.addSubview(contributeCountLabel)
        view.addSubview(byYouLabel)
        view.addSubview(dismissButton)
        
        setupConfirmImageView()
        setupSentenceLabel()
        setupcontributeCountLabel()
        setupByYouLabel()
        setupDismissButton()
    }
    
    // MARK: - View
    let confirmImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pactConfirmLogo.png")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var sentenceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "this is the confirmation sentence"
        label.backgroundColor = UIColor.black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.darkGray
        return label
    }()
    
    var contributeCountLabel: UILabel = {
        let label = UILabel()
        label.text = "10"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 80)
        label.textColor = UIColor.darkGray
        return label
    }()
    
    let byYouLabel: UILabel = {
        let label = UILabel()
        label.text = "by you"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 40)
        label.textColor = UIColor.darkGray
        return label
    }()
    
    let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 183/255, green: 56/255, blue: 42/255, alpha: 1)
        button.setTitle("DISMISS", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    func setupConfirmImageView() {
        // need x, y, width and height constraints
        confirmImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        confirmImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        confirmImageView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        confirmImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
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
        self.dismiss(animated: true, completion: nil)
    }
}
