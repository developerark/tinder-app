//
//  User.swift
//  tinder-app
//
//  Created by Aswin Raj Kharel on 12/25/18.
//  Copyright © 2018 Aswin Raj Kharel. All rights reserved.
//

import UIKit

struct User: ProducesCardViewModel {
    
    // Define the properties for the User Data Model
    let name: String
    let age: Int
    let profession: String
    let imageName: String
    
    func toCardViewModel() -> CardViewModel{
        let attributedText = NSMutableAttributedString(string: self.name, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
        attributedText.append(NSAttributedString(string: "   \(self.age)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular)]))
        attributedText.append(NSAttributedString(string: "\n\(self.profession)", attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium)]))
        return CardViewModel(imageName: self.imageName, attributedString: attributedText, textAlignment: .left)
    }
    

}
