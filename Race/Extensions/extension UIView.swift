//
//  extension UIView.swift
//  Race
//
//  Created by Alina Sakovskaya on 5.09.23.
//

import UIKit

extension UIView {
    func adGradientBackgroundColor(firstColor: UIColor, secondColor: UIColor) {
        let gradientColor = CAGradientLayer()
        gradientColor.frame = bounds
        gradientColor.colors = [firstColor.cgColor, secondColor.cgColor]
        gradientColor.startPoint = CGPoint(x: 0.7, y: 0.5)
        gradientColor.endPoint = CGPoint(x: 1.0, y: 1.0)
        layer.insertSublayer(gradientColor, at: 0)
    }
}
