//
//  CardView.swift
//  tinder-app
//
//  Created by Aswin Raj Kharel on 12/23/18.
//  Copyright © 2018 Aswin Raj Kharel. All rights reserved.
//

import UIKit

class CardView: UIView {
    var cardViewModel: CardViewModel!{
        didSet{
            self.imageView.image = UIImage(named: cardViewModel.imageName)
            informationLabel.attributedText = cardViewModel.attributedString
            informationLabel.textAlignment = cardViewModel.textAlignment
        }
    }
    
    fileprivate let imageView = UIImageView(image: #imageLiteral(resourceName: "lady5c"))
    fileprivate let informationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "MY LABEL"
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        return label
    }()
    
    // MARK:- Configuration
    fileprivate let threshold: CGFloat = 100
    
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
        
        self.addSubview(self.informationLabel)
        self.informationLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        self.informationLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 10).isActive = true
        self.informationLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        self.informationLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    

    enum DismissDirection{
        case right
        case left
    }
    fileprivate func handleEnded(gesture: UIPanGestureRecognizer) {
        let shouldDismissCard = abs(gesture.translation(in: nil).x) > threshold
        var dismissDirection: DismissDirection = .right
        if shouldDismissCard{
            if gesture.translation(in: nil).x > 0{
                dismissDirection = .right
            }else{
                dismissDirection = .left
            }
        }
        
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            if shouldDismissCard{
                if dismissDirection == .right{
                    self.frame = CGRect(x: 600, y: 0, width: self.frame.width, height: self.frame.height)
                }else{
                    self.frame = CGRect(x: -600, y: 0, width: self.frame.width, height: self.frame.height)
                }
            }else{
                self.transform = .identity
            }
        }) { (_) in
            self.transform = .identity
            if shouldDismissCard{
                self.removeFromSuperview()
            }
        }
    }
    
    fileprivate func handleChanged(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: nil)
        let rotationInDegree = translation.x / 20
        let rotationalTransformation = CGAffineTransform(rotationAngle: 3.14/180 * rotationInDegree)
        self.transform = rotationalTransformation
        self.transform = rotationalTransformation.translatedBy(x: translation.x, y: translation.y)
    }
    
    @objc fileprivate func handlePan(sender: UIPanGestureRecognizer){
        switch sender.state {
        case .changed:
            handleChanged(sender)
        case .ended:
            handleEnded(gesture: sender)
        default:
            ()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
