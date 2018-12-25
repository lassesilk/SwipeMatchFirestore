//
//  RegistrationViewModel.swift
//  SwipeMatchFirestore
//
//  Created by Lasse Silkoset on 25/12/2018.
//  Copyright © 2018 Lasse Silkoset. All rights reserved.
//

import UIKit

class RegistrationViewModel {
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
    
    fileprivate func checkFormValidity() {
        let isFormValid = fullname?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
        isFormValidObserver?(isFormValid)
    }
    
    //Reactive programming
    var isFormValidObserver: ((Bool) -> ())?
}
