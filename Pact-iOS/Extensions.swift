//
//  Extensions.swift
//  Pact-iOS
//
//  Created by matt on 2017-05-11.
//  Copyright © 2017 matt. All rights reserved.
//

import UIKit
import Firebase

extension UIImageView {
    func loadImageUsingCacheWithImageName(imageName: String) {
        // firebase storageRef
        let storage = FIRStorage.storage()
        let storageRef = storage.reference()
        
        // download profile image
        let coverImageRef = storageRef.child("profileImages").child(imageName)
        
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
                    self.image = imageData
                    self.layer.masksToBounds = true
                    self.layer.cornerRadius = self.frame.size.height / 2
                }
                
            }).resume()
            
        })
        
    }
}

