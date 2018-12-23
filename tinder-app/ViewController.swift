//
//  ViewController.swift
//  tinder-app
//
//  Created by Aswin Raj Kharel on 12/12/18.
//  Copyright © 2018 Aswin Raj Kharel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let topStackView = TopNavigationStackView()
    let blueView = UIView()
    let  buttonsStackView = HomeBottomControllStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
            blueView.backgroundColor = .blue

        self.setupLayout()
    }

    // MARK:- Layout Setup
    fileprivate func setupLayout() {
        let overallStackView = UIStackView(arrangedSubviews: [topStackView, blueView, buttonsStackView])
        overallStackView.axis = .vertical
        overallStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(overallStackView)
        overallStackView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        overallStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        overallStackView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        overallStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

