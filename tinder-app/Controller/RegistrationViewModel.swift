//
//  RegistrationViewModel.swift
//  tinder-app
//
//  Created by Aswin Raj Kharel on 12/30/18.
//  Copyright © 2018 Aswin Raj Kharel. All rights reserved.
//

import UIKit

class RegistrationViewModel{
    var fullName: String?{didSet{self.checkFormValidity()}}
    var email: String?{didSet{self.checkFormValidity()}}
    var password: String?{didSet{self.checkFormValidity()}}
    
    fileprivate func checkFormValidity(){
        let isFormValid = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
        self.isFormValidObserver?(isFormValid)
    }
    
    // Reactive Programming
    var isFormValidObserver: ((Bool) -> ())?
}
