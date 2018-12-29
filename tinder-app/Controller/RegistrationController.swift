//
//  RegistrationController.swift
//  tinder-app
//
//  Created by Aswin Raj Kharel on 12/29/18.
//  Copyright © 2018 Aswin Raj Kharel. All rights reserved.
//

import UIKit

class RegistrationController: UIViewController {
    
    // UI Components
    let selectPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select Photo", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 250).isActive = true // Dont specify .fillEqually for distribution for custom height
        button.layer.cornerRadius = 16
        return button
    }()
    
    let fullNameTextField: UITextField = {
        let tf = CustomTextField(padding: 24)
        tf.placeholder = "Enter full name"
        tf.backgroundColor = .white
        tf.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return tf
    }()
    
    let emailTextField: UITextField = {
        let tf = CustomTextField(padding: 24)
        tf.placeholder = "Enter email"
        tf.backgroundColor = .white
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = CustomTextField(padding: 24)
        tf.placeholder = "Enter password"
        tf.isSecureTextEntry = true
        tf.backgroundColor = .white
        return tf
    }()
    
    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        button.backgroundColor = #colorLiteral(red: 0.8132490516, green: 0.09731306881, blue: 0.3328936398, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true // Dont specify .fillEqually for distribution for custom height
        button.layer.cornerRadius = 25
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupGradientLayer()
        let stackView = UIStackView(arrangedSubviews: [self.selectPhotoButton, self.fullNameTextField, self.emailTextField, self.passwordTextField, self.registerButton])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stackView)
        stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    
        
    }
    
    fileprivate func setupGradientLayer(){
        let gradientLayer = CAGradientLayer()
        let topColor = #colorLiteral(red: 0.9893609881, green: 0.3810070455, blue: 0.3745059073, alpha: 1)
        let bottomColor = #colorLiteral(red: 0.8936758637, green: 0.1074005738, blue: 0.4637162685, alpha: 1)
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0, 1]
        view.layer.addSublayer(gradientLayer)
        gradientLayer.frame = self.view.bounds
    }
}
