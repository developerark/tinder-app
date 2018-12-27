//
//  CardViewModel.swift
//  tinder-app
//
//  Created by Aswin Raj Kharel on 12/25/18.
//  Copyright © 2018 Aswin Raj Kharel. All rights reserved.
//

import UIKit

protocol ProducesCardViewModel {
    func toCardViewModel() -> CardViewModel;
}

class CardViewModel {
    // Define proterties that view will desplay or render out
    let imageNames: [String]
    let attributedString: NSAttributedString
    let textAlignment: NSTextAlignment
    
    init(imageNames: [String], attributedString: NSAttributedString, textAlignment: NSTextAlignment){
        self.imageNames = imageNames
        self.attributedString = attributedString
        self.textAlignment = textAlignment
    }
    
    fileprivate var imageIndex = 0{
        didSet{
            let imageName = self.imageNames[self.imageIndex]
            let image = UIImage(named: imageName)
            imageIndexObserver?(self.imageIndex, image)
        }
    }
    
    // Reactive Programming
    var imageIndexObserver: ((Int, UIImage?) -> ())?
    func advanceToNextPhoto(){
        imageIndex = min(imageIndex + 1, imageNames.count - 1)
    }
    
    func goToPreviousPhoto(){
        imageIndex = max(0, imageIndex - 1)
    }
}

