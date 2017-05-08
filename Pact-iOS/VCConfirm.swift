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
import BEMCheckBox

class VCConfirm: UIViewController {
    
    let checkBox = BEMCheckBox()
    
    weak var modalDelegate: ModalViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.backgroundBeige
        
    
        view.addSubview(headerView)
        view.addSubview(checkBox)
        view.addSubview(sentenceLabel)
        view.addSubview(contributeCountLabel)
        view.addSubview(byYouLabel)
        view.addSubview(dismissButton)
        
        setupHeaderView()
        setupCheckMark()
        setupSentenceLabel()
        setupcontributeCountLabel()
        setupByYouLabel()
        setupDismissButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        perform(#selector(handleCheckMarkOn), with: nil, afterDelay: 0.3)
    }
    
    // MARK: - View
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.pactRed
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let logoView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pactLogo.png")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var sentenceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let attributedString = NSMutableAttributedString(string: "Thank you for backing this project! Togeteher we planted 122 trees!")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 14
        attributedString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        label.attributedText = attributedString
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.textDarkGrey
        return label
    }()
    
    var contributeCountLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 80)
        label.textColor = UIColor.pactRed
        return label
    }()
    
    let byYouLabel: UILabel = {
        let label = UILabel()
        label.text = "by you"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = UIColor.textDarkGrey
        if DeviceUtil.height <= CGFloat(568.0) {
            label.font = UIFont.systemFont(ofSize: 24)
        }
        return label
    }()
    
    let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.4)
        button.setTitle("DISMISS", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor.pactRed
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        button.addTarget(self, action: #selector(handleCheckMarkOff), for: .touchUpInside)
        return button
    }()
    
    func setupHeaderView() {
        headerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        headerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35).isActive = true
        headerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        headerView.addSubview(logoView)
        
        setupLogoView()
    }
    
    func setupLogoView() {
        // need x, y, width and height constraints
        logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        logoView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -200).isActive = true
        logoView.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func setupCheckMark() {
        checkBox.lineWidth = 3
        checkBox.onAnimationType = BEMAnimationType.stroke
        checkBox.offAnimationType = BEMAnimationType.oneStroke
        checkBox.onTintColor = UIColor.white
        checkBox.onCheckColor = UIColor.white
        checkBox.animationDuration = 0.4
        
        let viewWidth: CGFloat = view.frame.size.width
        checkBox.frame = CGRect(x: (viewWidth / 2) - 35, y: 110, width: 70, height: 70)
    }
    
    func setupSentenceLabel() {
        sentenceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sentenceLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 30).isActive = true
        sentenceLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.90).isActive = true
    }
    
    func setupcontributeCountLabel() {
        contributeCountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        contributeCountLabel.topAnchor.constraint(equalTo: sentenceLabel.bottomAnchor, constant: 35).isActive = true
    }
    
    func setupByYouLabel() {
        byYouLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        byYouLabel.topAnchor.constraint(equalTo: contributeCountLabel.bottomAnchor, constant: 20).isActive = true
    }
    
    func setupDismissButton() {
        dismissButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dismissButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -48).isActive = true
        dismissButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        // dismiss button bottom anchor adjustment
        var dismissButtonBottomAnchor = dismissButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -44)
        dismissButtonBottomAnchor.isActive = true
        if DeviceUtil.height <= CGFloat(568.0) {
            dismissButtonBottomAnchor.isActive = false
            dismissButtonBottomAnchor = dismissButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
            dismissButtonBottomAnchor.isActive = true
        }
    }

    
    // MARK: - Func
    func handleCheckMarkOn() {
        checkBox.setOn(true, animated: true)
    }
    
    func handleCheckMarkOff() {
        checkBox.setOn(false, animated: true)
        perform(#selector(handleDismiss), with: nil, afterDelay: 0.4)
    }
    
    func handleDismiss() {
        modalDelegate?.modalViewControllerDismiss(callbackData: nil)
        //self.dismiss(animated: true, completion: nil)
    }
}
