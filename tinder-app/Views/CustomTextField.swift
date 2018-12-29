//
//  CustomTextField.swift
//  tinder-app
//
//  Created by Aswin Raj Kharel on 12/29/18.
//  Copyright © 2018 Aswin Raj Kharel. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    let padding: Int
    init(padding: Int){
        self.padding = padding
        super.init(frame: .zero)
        
        self.layer.cornerRadius = 25
        self.clipsToBounds = true
    }
    override var intrinsicContentSize: CGSize{
        return CGSize(width: 0, height: 50)
    }
    
    // Padding text field
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: CGFloat(self.padding), dy: 0)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: CGFloat(self.padding), dy: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
