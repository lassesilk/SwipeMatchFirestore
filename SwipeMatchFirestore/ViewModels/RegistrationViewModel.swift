//
//  RegistrationViewModel.swift
//  SwipeMatchFirestore
//
//  Created by Lasse Silkoset on 25/12/2018.
//  Copyright © 2018 Lasse Silkoset. All rights reserved.
//

import UIKit
import Firebase

class RegistrationViewModel {
    
    var bindableIsRegistering = Bindable<Bool>()
    var bindableImage = Bindable<UIImage>()
    var bindableIsFormValid = Bindable<Bool>()
    
    var fullname: String? {
        didSet {
            checkFormValidity()
        }
    }
    var email: String? {
        didSet {
            checkFormValidity()
        }
    }
    var password: String? {
        didSet {
            checkFormValidity()
        }
    }
    
    func performRegistration(completion: @escaping (Error?) ->()) {
        
        guard let email = email, let password = password else { return }
        
        bindableIsRegistering.value = true
        
        Auth.auth().createUser(withEmail: email, password: password) { (res, err) in
            if let err = err {
                print(err)
                completion(err)
                return
            }
            
            print("successfully registered user:", res?.user.uid ?? "")
            
            self.saveImageToFirebase(completion: completion)
            
        }
    }
    
    fileprivate func saveImageToFirebase(completion: @escaping (Error?) -> ()) {
        let filename = UUID().uuidString
        let ref = Storage.storage().reference(withPath: "/images/\(filename)")
        let imageData = self.bindableImage.value?.jpegData(compressionQuality: 0.75) ?? Data()
        
        ref.putData(imageData, metadata: nil, completion: { (_, err) in
            
            if let err = err {
                completion(err)
                return
            }
            
            print("Finished uploading image to storage")
            ref.downloadURL(completion: { (url, err) in
                if let err = err {
                    completion(err)
                    return
                }
                self.bindableIsRegistering.value = false
                print("Download url of our image is:", url?.absoluteString ?? "")
                // Store the download url into firestore next lesson
                
                let imageUrl = url?.absoluteString ?? ""
                self.saveInfoToFirestore(imageUrl: imageUrl, completion: completion)
                completion(nil)
            })
        })
    }
    
    fileprivate func saveInfoToFirestore(imageUrl: String, completion: @escaping (Error?) ->()) {
        
        let uid = Auth.auth().currentUser?.uid ?? "" //guard maybe? should not store under empty string in firestore
        let docData = ["fullname": fullname ?? "", "uid": uid, "imageUrl1": imageUrl]
        
        Firestore.firestore().collection("users").document(uid).setData(docData) { (err) in
            if let err = err {
                completion(err)
                return
            }
            
            completion(nil)
        }
    }
    
    fileprivate func checkFormValidity() {
        let isFormValid = fullname?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
        
        bindableIsFormValid.value = isFormValid
    }
}
