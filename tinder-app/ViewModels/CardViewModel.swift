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

struct CardViewModel {
    // Define proterties that view will desplay or render out
    let imageNames: [String]
    let attributedString: NSAttributedString
    let textAlignment: NSTextAlignment
}

