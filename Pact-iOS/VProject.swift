//
//  ProjectView.swift
//  Pact-iOS
//
//  Created by matt on 2017-04-29.
//  Copyright © 2017 matt. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

protocol VProjectDelegate: class {
    func tappedContributeBtn(project: Project)
}


class VProject: UIView {
    
    var delegate: VProjectDelegate?
    var projectOptional: Project?
    
    @IBOutlet weak var pointsNeededLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var sponsorImage: UIImageView!
    @IBOutlet weak var contributeButton: UIButton!
    
    // constraints outlet
    @IBOutlet weak var pointsLabelTopCons: NSLayoutConstraint!
    @IBOutlet weak var titleLabeltopCons: NSLayoutConstraint!
    @IBOutlet weak var descriptionLabelTopCons: NSLayoutConstraint!
    @IBOutlet weak var sponsorImageWidthConst: NSLayoutConstraint!
    @IBOutlet weak var sponsorImageHeightConst: NSLayoutConstraint!
    @IBOutlet weak var sponsorImageYCons: NSLayoutConstraint!
    @IBOutlet weak var contributeButtonHeightCons: NSLayoutConstraint!
    @IBOutlet weak var coverImageHeightCons: NSLayoutConstraint!
    
    @IBAction func contributeBtnPressed(_ sender: Any) {
        if let project = projectOptional {
            delegate?.tappedContributeBtn(project: project)
        }
    }
    
    func updateProjectView(project: Project) {
        
        // set project object
        self.projectOptional = project
        
        // points label
        pointsNeededLabel.text = project.pointsNeeded + " pts"
        pointsNeededLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        // title text
        titleLabel.text = project.title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        
        // description text
        let attributedString = NSMutableAttributedString(string: project.description)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        attributedString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        descriptionLabel.attributedText = attributedString
        descriptionLabel.font = UIFont.systemFont(ofSize: 12)
        
        // contribute button
        contributeButton.setTitle(project.buttonText, for: .normal)
        contributeButton.layer.cornerRadius = 8
        contributeButton.layer.masksToBounds = true
        contributeButton.backgroundColor = project.buttonColors[Int(project.buttonColorIndex)!]
        
        // iphone 5
        if DeviceUtil.height <= CGFloat(568.0) {
            
            // points label
            pointsNeededLabel.text = project.pointsNeeded + " pts"
            pointsNeededLabel.font = UIFont.boldSystemFont(ofSize: 15)
            
            // title text
            titleLabel.text = project.title
            titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
            
            // description text
            let attributedString = NSMutableAttributedString(string: project.description)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 4
            attributedString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
            descriptionLabel.attributedText = attributedString
            descriptionLabel.font = UIFont.systemFont(ofSize: 10)
            descriptionLabel.numberOfLines = 3
            
            // contribute button
            contributeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
            
            // update constraints
            DispatchQueue.main.async {
                self.pointsLabelTopCons.constant = 10
                self.titleLabeltopCons.constant = 8
                self.descriptionLabelTopCons.constant = 8
                self.sponsorImageWidthConst.constant = 48
                self.sponsorImageHeightConst.constant = 48
                self.sponsorImageYCons.constant = 24
                self.contributeButtonHeightCons.constant = 45
            }
            
        } else if DeviceUtil.height >= CGFloat(736.0) {
            // points label
            pointsNeededLabel.text = project.pointsNeeded + " pts"
            pointsNeededLabel.font = UIFont.boldSystemFont(ofSize: 22)
            
            // title text
            titleLabel.text = project.title
            titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
            
            // description text
            let attributedString = NSMutableAttributedString(string: project.description)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 5
            attributedString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
            descriptionLabel.attributedText = attributedString
            descriptionLabel.font = UIFont.systemFont(ofSize: 14)
            
            // contribute button
            contributeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            
            // update constraints
            DispatchQueue.main.async {
                self.pointsLabelTopCons.constant = 20
                self.titleLabeltopCons.constant = 15
                self.descriptionLabelTopCons.constant = 15
                self.sponsorImageWidthConst.constant = 64
                self.sponsorImageHeightConst.constant = 64
                self.sponsorImageYCons.constant = 32
                self.contributeButtonHeightCons.constant = 60
                self.coverImageHeightCons.constant = 10
            }
            
        } else {
            // set up for iphone regular
        }
        
        
        // images
        coverImage.layer.masksToBounds = true 
        sponsorImage.layer.masksToBounds = true
        
        // firebase storageRef
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        // download cover image
        let coverImageName = project.coverImageName
        let coverImageRef = storageRef.child(coverImageName)
        
        coverImageRef.downloadURL(completion: { (url, error) in
            
            if error != nil {
                print(error?.localizedDescription as Any)
                return
            }
            
            URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                
                if error != nil {
                    print(error!)
                    return
                }
                
                guard let imageData = UIImage(data: data!) else { return }
                
                DispatchQueue.main.async {
                    self.coverImage.image = imageData
                }
                
            }).resume()
            
        })
        
        // download sponsor image
        let sponsorImageName = project.sponsorImageName
        let sponsorImageRef = storageRef.child(sponsorImageName)
        
        sponsorImageRef.downloadURL(completion: { (url, error) in
            
            if error != nil {
                print(error?.localizedDescription as Any)
                return
            }
            
            URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                
                if error != nil {
                    print(error!)
                    return
                }
                
                guard let imageData = UIImage(data: data!) else { return }
                
                DispatchQueue.main.async {
                    self.sponsorImage.image = imageData
                }
                
            }).resume()
            
        })
        
    }
    

}
