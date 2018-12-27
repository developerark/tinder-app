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
            let imageName = cardViewModel.imageNames.first ?? ""
            self.imageView.image = UIImage(named: imageName)
            informationLabel.attributedText = cardViewModel.attributedString
            informationLabel.textAlignment = cardViewModel.textAlignment
            
            (0..<cardViewModel.imageNames.count).forEach { (_) in
                let barView = UIView()
                barView.backgroundColor = self.barDeselectedColor
                barView.layer.cornerRadius = 3
                barView.clipsToBounds = true
                barsStackView.addArrangedSubview(barView)
            }
            barsStackView.arrangedSubviews.first?.backgroundColor = .white
            
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
    
    fileprivate func setupLayout() {
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
        
        self.setupBarStackView()
        
        // Add a gratient layer
        self.setupGradientLayer()
        
        self.addSubview(self.informationLabel)
        self.informationLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        self.informationLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 10).isActive = true
        self.informationLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        self.informationLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    fileprivate let barsStackView = UIStackView()
    func setupBarStackView(){
        self.barsStackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.barsStackView)
        self.barsStackView.backgroundColor = .red
        self.barsStackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        self.barsStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        self.barsStackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        self.barsStackView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        self.barsStackView.spacing = 4
        self.barsStackView.distribution = .fillEqually
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(sender:)))
        self.addGestureRecognizer(panGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        self.addGestureRecognizer(tapGesture)
    }
    var imageIndex = 0
    fileprivate let barDeselectedColor = UIColor(white: 0, alpha: 0.1)
    @objc fileprivate func handleTap(sender: UITapGestureRecognizer){
        print("Handling Tap")
        let tapLocation = sender.location(in: nil)
        let shouldAdvanceNextPhoto = tapLocation.x > self.frame.width / 2 ? true : false
        if shouldAdvanceNextPhoto{
            self.imageIndex = min(imageIndex + 1, cardViewModel.imageNames.count - 1)
        }else{
            self.imageIndex = max(0, imageIndex - 1)
        }
        let imageName = cardViewModel.imageNames[imageIndex]
        self.imageView.image = UIImage(named: imageName)
        self.barsStackView.arrangedSubviews.forEach { (view) in
            view.backgroundColor = self.barDeselectedColor
        }
        self.barsStackView.arrangedSubviews[imageIndex].backgroundColor = .white
    }
    
    fileprivate let gradientLayer = CAGradientLayer()
    
    func setupGradientLayer(){
        // Draw the gradient
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5, 1.1]
        gradientLayer.frame = CGRect(x: 0, y: 0, width: 300, height: 400)
        self.layer.addSublayer(gradientLayer)
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
        case .began:
            // Remove all animation of drag start
            superview?.subviews.forEach({ (subview) in
                subview.layer.removeAllAnimations()
            })
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
    
    override func layoutSubviews() {
        gradientLayer.frame = self.frame
    }
}
