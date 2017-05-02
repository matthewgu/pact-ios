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
        // TODO: change text font 
        let attributedString = NSMutableAttributedString(string: project.description)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        attributedString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        descriptionLabel.attributedText = attributedString
        
        // contribute button
        contributeButton.setTitle(project.buttonText, for: .normal)
        contributeButton.layer.cornerRadius = 8
        contributeButton.layer.masksToBounds = true
        contributeButton.backgroundColor = UIColor.customBlue
        //project.buttonColour
        
        // images
        coverImage.layer.masksToBounds = true
        sponsorImage.layer.masksToBounds = true
        
        // firebase storageRef
        let storage = FIRStorage.storage()
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
