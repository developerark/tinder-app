//
//  CardView.swift
//  tinder-app
//
//  Created by Aswin Raj Kharel on 12/23/18.
//  Copyright © 2018 Aswin Raj Kharel. All rights reserved.
//

import UIKit

class CardView: UIView {
    fileprivate let imageView = UIImageView(image: #imageLiteral(resourceName: "lady5c"))
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Custom Drawing code
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.addSubview(self.imageView)
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.leftAnchor.constraint(equalTo: (imageView.superview?.leftAnchor)!, constant: 0).isActive = true
        self.imageView.topAnchor.constraint(equalTo: (imageView.superview?.topAnchor)!, constant: 0).isActive = true
        self.imageView.rightAnchor.constraint(equalTo: (imageView.superview?.rightAnchor)!, constant: 0).isActive = true
        self.imageView.bottomAnchor.constraint(equalTo: (imageView.superview?.bottomAnchor)!, constant: 0).isActive = true
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(sender:)))
        self.addGestureRecognizer(panGesture)
    }
    
    fileprivate func handleEnded() {
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            self.transform = .identity
        }) { (_) in
            
        }
    }
    
    fileprivate func handleChanged(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: nil)
        self.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
    }
    
    @objc fileprivate func handlePan(sender: UIPanGestureRecognizer){
        switch sender.state {
        case .changed:
            handleChanged(sender)
        case .ended:
            handleEnded()
        default:
            ()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
