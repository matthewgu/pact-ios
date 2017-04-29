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
    func tappedContributeBtn()
}


class VProject: UIView {
    
    var delegate: VProjectDelegate?
    
    @IBOutlet weak var pointsNeededLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var sponsorImage: UIImageView!
    
    @IBOutlet weak var contributeButton: UIButton!
    
    @IBAction func contributeBtnPressed(_ sender: Any) {
        delegate?.tappedContributeBtn()
    }
    
    func updateProjectView(project: Project) {
        pointsNeededLabel.text = project.pointsNeeded + " pts"
        titleLabel.text = project.title
        descriptionLabel.text = project.description
        
        // contribute button
        contributeButton.setTitle(project.buttonText, for: .normal)
        contributeButton.layer.cornerRadius = 8
        contributeButton.layer.masksToBounds = true
        contributeButton.backgroundColor = project.buttonColour
        
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
