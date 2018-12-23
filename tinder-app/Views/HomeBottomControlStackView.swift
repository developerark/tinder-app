//
//  HomeBottomControlStackView.swift
//  tinder-app
//
//  Created by Aswin Raj Kharel on 12/23/18.
//  Copyright © 2018 Aswin Raj Kharel. All rights reserved.
//

import UIKit

class HomeBottomControllStackView: UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let subviews = [#imageLiteral(resourceName: "refresh_circle"), #imageLiteral(resourceName: "dismiss_circle"), #imageLiteral(resourceName: "super_like_circle"), #imageLiteral(resourceName: "like_circle"), #imageLiteral(resourceName: "boost_circle")].map { (image) -> UIView in
            let button = UIButton(type: .system)
            button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
            return button
        }
        self.distribution = .fillEqually
        self.axis = .horizontal
        self.heightAnchor.constraint(equalToConstant: 100).isActive = true
        self.translatesAutoresizingMaskIntoConstraints = false
        subviews.forEach { (view) in
            self.addArrangedSubview(view)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
