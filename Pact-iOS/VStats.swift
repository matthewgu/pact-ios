//
//  VStats.swift
//  Pact-iOS
//
//  Created by matt on 2017-05-06.
//  Copyright © 2017 matt. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class VStats: UIView {

    @IBOutlet weak var projectIcon: UIImageView!
    @IBOutlet weak var statsLabel: UILabel!
    
    func updateStatsView(project: Project) {
        //stats label
        var statsText = project.itemVerb + " " + project.contributeCount + " " + project.itemName
        statsText = statsText.capitalizeFirst()
        statsLabel.text = statsText
        statsLabel.font = UIFont.boldSystemFont(ofSize: 13)
        statsLabel.textColor = UIColor.textDarkGrey
        
        // images
        projectIcon.layer.masksToBounds = true
        projectIcon.layer.cornerRadius = projectIcon.frame.size.height / 2
        
        projectIcon.loadProjectIconUsingCacheWithImageName(imageName: project.projectIconName)
        
//        // firebase storageRef
//        let storage = FIRStorage.storage()
//        let storageRef = storage.reference()
//        
//        // download project icon
//        let iconName = project.projectIconName
//        let iconImageRef = storageRef.child(iconName)
//        
//        iconImageRef.downloadURL(completion: { (url, error) in
//            
//            if error != nil {
//                print(error?.localizedDescription as Any)
//                return
//            }
//            
//            URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
//                
//                if error != nil {
//                    print(error!)
//                    return
//                }
//                
//                guard let imageData = UIImage(data: data!) else { return }
//                
//                DispatchQueue.main.async {
//                    self.projectIcon.image = imageData
//                }
//                
//            }).resume()
//            
//        })
        
    }
    
}

extension String {
    func capitalizeFirst() -> String {
        let firstIndex = self.index(startIndex, offsetBy: 1)
        return self.substring(to: firstIndex).capitalized + self.substring(from: firstIndex).lowercased()
    }
}
