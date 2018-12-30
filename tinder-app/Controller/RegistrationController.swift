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
    
    lazy var verticalStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            self.fullNameTextField,
            self.emailTextField,
            self.passwordTextField,
            self.registerButton
            ])
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.spacing = 8
        return sv
    }()
    
    lazy var overallStackView = UIStackView(arrangedSubviews: [
            self.selectPhotoButton,
            self.verticalStackView
        ])
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if self.traitCollection.verticalSizeClass == .compact{
            self.overallStackView.axis = .horizontal
        }else{
            self.overallStackView.axis = .vertical
        }
    }
    
    fileprivate func setupLayout() {
        self.overallStackView.axis = .vertical
        self.selectPhotoButton.widthAnchor.constraint(equalToConstant: 275).isActive = true
        self.overallStackView.spacing = 8
        self.overallStackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(overallStackView)
        self.overallStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50).isActive = true
        self.overallStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50).isActive = true
        self.overallStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupGradientLayer()
        setupLayout()
        self.setupNotificationObservers()
        
        self.setupTapGesture()
    }
    
    fileprivate func setupTapGesture(){
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss(sender:))))
    }
    
    @objc func handleTapDismiss(sender: UITapGestureRecognizer){
        self.view.endEditing(true)
        
    }
    
    func setupNotificationObservers(){
        // Showing keyboard notification
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // Hiding keyboard notification
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)         // Avoiding retain cycle
    }
    
    @objc fileprivate func handleKeyboardHide(sender: Notification){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.transform = .identity
        }, completion: nil)
        
    }
    
    
    
    @objc fileprivate func handleKeyboardShow(sender: Notification){
        guard let value = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardFrame = value.cgRectValue
        print(keyboardFrame)
        
        // gap from bottom of register bottom to bottom of screen
        let bottomSpace = view.frame.height - self.overallStackView.frame.origin.y - self.overallStackView.frame.height
        let difference = keyboardFrame.height - bottomSpace
        self.view.transform = CGAffineTransform(translationX: 0, y: -difference - 8)
        
    }
    
    let gradientLayer = CAGradientLayer()
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.gradientLayer.frame = self.view.bounds
    }
    
    fileprivate func setupGradientLayer(){
        let topColor = #colorLiteral(red: 0.9893609881, green: 0.3810070455, blue: 0.3745059073, alpha: 1)
        let bottomColor = #colorLiteral(red: 0.8936758637, green: 0.1074005738, blue: 0.4637162685, alpha: 1)
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0, 1]
        view.layer.addSublayer(gradientLayer)
        gradientLayer.frame = self.view.bounds
    }
}
