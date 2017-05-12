//
//  VCProfile+handlers.swift
//  Pact-iOS
//
//  Created by matt on 2017-05-11.
//  Copyright © 2017 matt. All rights reserved.
//

import UIKit
import Firebase

extension VCProfile: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func handleSelectProfileImageView() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("cancelled picker")
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = originalImage
        }

        if let selectedImage = selectedImageFromPicker {
            profileImageView.image = selectedImage
            profileImageView.layer.masksToBounds = true
            profileImageView.layer.cornerRadius = profileImageView.frame.size.height / 2
            uploadProfileImage()
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func uploadProfileImage() {
        let imageName = NSUUID().uuidString
        let storageRef = FIRStorage.storage().reference().child("profileImages").child("\(imageName).jpg")
        if let uploadData = UIImageJPEGRepresentation(profileImageView.image!, 0.1) {
            storageRef.put(uploadData, metadata: nil, completion: { (metaData, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                // uploading image to profile
                self.ref = FIRDatabase.database().reference()
                let uid = FIRAuth.auth()?.currentUser?.uid
                self.ref?.child("users/\(uid!)/profileImageName").setValue("\(imageName).jpg")
            })
        }
    }
    
}

