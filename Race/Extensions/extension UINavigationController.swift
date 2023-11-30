//
//  extension UINavigationController.swift
//  Race
//
//  Created by Alina Sakovskaya on 3.09.23.
//

import UIKit


extension UIViewController {
    
    func hideNavigationBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func addTapGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing(_:)))
        view.addGestureRecognizer(tapGesture)
    }
}
