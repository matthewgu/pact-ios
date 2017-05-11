//
//  Extensions.swift
//  Pact-iOS
//
//  Created by matt on 2017-05-11.
//  Copyright © 2017 matt. All rights reserved.
//

import UIKit
import Firebase

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func loadProjectIconUsingCacheWithImageName(imageName: String) {
        
        // check cachedImage
        if let cachedImage = imageCache.object(forKey: imageName as NSString) {
            DispatchQueue.main.async {
                self.layer.masksToBounds = true
                self.layer.cornerRadius = self.frame.size.height / 2
                self.image = cachedImage
            }
        } else { // otherwise fireoff firebase
            // firebase storageRef
            let storage = FIRStorage.storage()
            let storageRef = storage.reference()
            
            // download profile image
            let imageRef = storageRef.child(imageName)
            
            imageRef.downloadURL(completion: { (url, error) in
                
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
                        
                        imageCache.setObject(imageData, forKey: imageName as NSString)
                        self.image = imageData
                        self.layer.masksToBounds = true
                        self.layer.cornerRadius = self.frame.size.height / 2
                    }
                    
                }).resume()
                
            })
            
        }
    }
    
    func loadProfileImageUsingCacheWithImageName(imageName: String) {
        
        // check cachedImage
        if let cachedImage = imageCache.object(forKey: imageName as NSString) {
            DispatchQueue.main.async {
                self.layer.masksToBounds = true
                self.layer.cornerRadius = self.frame.size.height / 2
                self.image = cachedImage
            }
        } else { // otherwise fireoff firebase
            // firebase storageRef
            let storage = FIRStorage.storage()
            let storageRef = storage.reference()
            
            // download profile image
            let imageRef = storageRef.child("profileImages").child(imageName)
            
            imageRef.downloadURL(completion: { (url, error) in
                
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
                        
                        imageCache.setObject(imageData, forKey: imageName as NSString)
                        self.image = imageData
                        self.layer.masksToBounds = true
                        self.layer.cornerRadius = self.frame.size.height / 2
                    }
                    
                }).resume()
                
            })
            
        }
    }
}

