//
//  ViewController.swift
//  tinder-app
//
//  Created by Aswin Raj Kharel on 12/12/18.
//  Copyright © 2018 Aswin Raj Kharel. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    let topStackView = TopNavigationStackView()
    let cardsDeckView = UIView()
    let  buttonsStackView = HomeBottomControllStackView()
    
    let cardViewModels: [CardViewModel] = {
        let producers = [
            Advertiser(title: "OSX Mojave", brandName: "Apple", posterPhotoName: "slide_out_menu_poster"),
            User(name: "Kelly", age: 23, profession: "Teacher", imageNames: ["kelly1", "kelly2", "kelly3"]),
            User(name: "Jane", age: 18, profession: "Receptionist", imageNames: ["jane1", "jane2", "jane3"])
        ] as [ProducesCardViewModel]
        return producers.map({return $0.toCardViewModel()})
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        self.setupLayout()
        
        self.setupDummyCards()
    }
    
    // MARK:- Cards
    func setupDummyCards(){
        for cardViewModel in self.cardViewModels{
            let cardView = CardView()
            cardView.cardViewModel = cardViewModel
            cardsDeckView.addSubview(cardView)
            
            cardView.translatesAutoresizingMaskIntoConstraints = false
            cardView.leftAnchor.constraint(equalTo: (cardView.superview?.leftAnchor)!, constant: 0).isActive = true
            cardView.topAnchor.constraint(equalTo: (cardView.superview?.topAnchor)!, constant: 0).isActive = true
            cardView.rightAnchor.constraint(equalTo: (cardView.superview?.rightAnchor)!, constant: 0).isActive = true
            cardView.bottomAnchor.constraint(equalTo: (cardView.superview?.bottomAnchor)!, constant: 0).isActive = true
        }
    }

    // MARK:- Layout Setup
    fileprivate func setupLayout() {
        let overallStackView = UIStackView(arrangedSubviews: [topStackView, cardsDeckView, buttonsStackView])
        overallStackView.axis = .vertical
        overallStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(overallStackView)
        overallStackView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        overallStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        overallStackView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        overallStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        overallStackView.isLayoutMarginsRelativeArrangement = true
        overallStackView.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        
        overallStackView.bringSubviewToFront(self.cardsDeckView)
    }
}

