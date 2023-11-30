//
//  extension UIButton.swift
//  Race
//
//  Created by Alina Sakovskaya on 5.09.23.
//

import UIKit


extension UIButton {
    func animateButton() {
        let animationView = UIView(frame: CGRect(x: bounds.maxX, y: bounds.minY, width: bounds.width / 2, height: bounds.height))
        animationView.isUserInteractionEnabled = false
        addSubview(animationView)
        
        let gradient = CAGradientLayer()
        gradient.frame = animationView.bounds
        gradient.colors = [UIColor.magenta.cgColor, UIColor.black.cgColor]
        gradient.locations = [0, 1.0]
        gradient.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 0, y: 0)
        gradient.opacity = 0.5
        animationView.layer.addSublayer(gradient)
        
        UIView.animate(withDuration: 1.5, delay: 0, options: .repeat) {
            animationView.transform = animationView.transform.translatedBy(x: -self.bounds.maxX * 1.5, y: 0)
        }
    }
}
