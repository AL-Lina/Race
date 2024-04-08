//
//  StartViewController.swift
//  Race
//
//  Created by Alina Sakovskaya on 1.09.23.
//

import UIKit

class StartViewController: UIViewController {
    
    let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("START", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        button.backgroundColor = .black
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        return button
    }()
    
    let settingsButton: UIButton = {
        let button = UIButton()
        button.setTitle("SETTINGS", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        button.backgroundColor = .black
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        return button
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = ""
        
        startButton.animateButton()
        settingsButton.animateButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.adGradientBackgroundColor(firstColor: .black, secondColor: .purple)
        
        setUpScreen()
    }
    
    func setUpScreen() {
        
        view.addSubview(imageView)
        imageView.image = UIImage(named: "mainCar")
        
        startButton.frame = CGRect(x: 125, y: 300, width: 150, height: 70)
        view.addSubview(startButton)
        settingsButton.frame = CGRect(x: 125, y: 400, width: 150, height: 70)
        view.addSubview(settingsButton)
        
        startButton.addTarget(self, action: #selector(goToGameScreen), for: .primaryActionTriggered)
        settingsButton.addTarget(self, action: #selector(goToSettingsScreen), for: .primaryActionTriggered)
        
        NSLayoutConstraint.activate([
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 300)
            
        ])
    }
    
    @objc func goToGameScreen() {
        let gameViewController = GameViewController()
        navigationController?.pushViewController(gameViewController, animated: true)
    }
    
    @objc func goToSettingsScreen() {
        let settingsViewController = SettingsViewController()
        navigationController?.pushViewController(settingsViewController, animated: true)
    }
}




