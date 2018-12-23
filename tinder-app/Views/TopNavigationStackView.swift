//
//  TopNavigationStackView.swift
//  tinder-app
//
//  Created by Aswin Raj Kharel on 12/23/18.
//  Copyright © 2018 Aswin Raj Kharel. All rights reserved.
//

import UIKit

class TopNavigationStackView: UIStackView {
    let settingButton = UIButton(type: .system)
    let messageButton = UIButton(type: .system)
    let fireImageView = UIImageView(image: #imageLiteral(resourceName: "app_icon"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.heightAnchor.constraint(equalToConstant: 80).isActive = true
        self.distribution = .equalCentering
        self.fireImageView.contentMode = .scaleAspectFit
        self.settingButton.setImage(#imageLiteral(resourceName: "top_left_profile").withRenderingMode(.alwaysOriginal), for: .normal)
        self.messageButton.setImage(#imageLiteral(resourceName: "top_right_messages").withRenderingMode(.alwaysOriginal), for: .normal)
        [self.settingButton, UIView(), self.fireImageView, UIView(), self.messageButton].forEach { (view) in
            self.addArrangedSubview(view)
        }
        self.isLayoutMarginsRelativeArrangement = true
        layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
