//
//  SettingsViewController.swift
//  Race
//
//  Created by Alina Sakovskaya on 2.09.23.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let nameScreenLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ENTER YOUR NAME AND LOAD YOUR PHOTO"
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
    let chooseCarLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "CHOOSE A CAR"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
    let chooseLevelGameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "CHOOSE A GAME LEVEL"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        let configuration = UIImage.SymbolConfiguration(pointSize: 26, weight: .semibold)
        let image = UIImage(systemName: "chevron.backward.2", withConfiguration: configuration)
        button.configuration = UIButton.Configuration.filled()
        button.configuration?.baseForegroundColor = .white
        button.configuration?.baseBackgroundColor = .black
        button.configuration?.image = image
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        return button
    }()
    
    let nameTextField: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "NAME"
        textfield.returnKeyType = .done
        textfield.autocapitalizationType = .allCharacters
        textfield.backgroundColor = .white
        textfield.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        textfield.layer.cornerRadius = 10
        return textfield
    }()
    
    let stackForRightAndLeftButtons: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 150
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    var currentIndex = 0
    
    let arrayOfCars = [UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "3"), UIImage(named: "4"), UIImage(named: "5")]
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let leftButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.clipsToBounds = true
        button.frame.size = CGSize(width: 60, height: 60)
        button.setImage(UIImage(named: "leftArrow"), for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    let rightButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.clipsToBounds = true
        button.frame.size = CGSize(width: 60, height: 60)
        button.setImage(UIImage(named: "rightArrow"), for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    let avatarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 75
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "space")
        return imageView
    }()
    
    let gameSpeedSegmentedControl: UISegmentedControl = {
        let items = ["EASY", "MEDIUM", "HARD"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.backgroundColor = .white
        segmentedControl.selectedSegmentTintColor = .purple
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18, weight: .bold)], for: .normal)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.layer.cornerRadius = 15.0
        return segmentedControl
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        leftButton.animateButton()
        rightButton.animateButton()
        load()
        loadImage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.adGradientBackgroundColor(firstColor: .black, secondColor: .purple)
        
        addTapGestureToHideKeyboard()
        
        setUpScreen()
        
        createTapGester()
        
        self.hideNavigationBar()
        
        nameTextField.delegate = self
    }
    
    func setUpScreen() {
        view.addSubview(imageView)
        view.addSubview(backButton)
        view.addSubview(nameScreenLabel)
        view.addSubview(nameTextField)
        view.addSubview(chooseCarLabel)
        view.addSubview(avatarImage)
        view.addSubview(stackForRightAndLeftButtons)
        stackForRightAndLeftButtons.addArrangedSubview(leftButton)
        stackForRightAndLeftButtons.addArrangedSubview(rightButton)
        view.addSubview(chooseLevelGameLabel)
        view.addSubview(gameSpeedSegmentedControl)
        
        backButton.addTarget(self, action: #selector(goBack), for: .primaryActionTriggered)
        imageView.image = arrayOfCars[currentIndex]
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            backButton.heightAnchor.constraint(equalToConstant: 30),
            backButton.widthAnchor.constraint(equalToConstant: 50),
            nameScreenLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 20),
            nameScreenLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            nameScreenLabel.widthAnchor.constraint(equalToConstant: 200),
            nameTextField.topAnchor.constraint(equalTo: nameScreenLabel.bottomAnchor, constant: 20),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            nameTextField.widthAnchor.constraint(equalToConstant: 200),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            avatarImage.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 16),
            avatarImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            avatarImage.heightAnchor.constraint(equalToConstant: 150),
            avatarImage.widthAnchor.constraint(equalToConstant: 150),
            chooseCarLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            chooseCarLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 36),
            imageView.topAnchor.constraint(equalTo: chooseCarLabel.bottomAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 150),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -150),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            stackForRightAndLeftButtons.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            stackForRightAndLeftButtons.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            stackForRightAndLeftButtons.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
            stackForRightAndLeftButtons.heightAnchor.constraint(equalToConstant: 60),
            chooseLevelGameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            chooseLevelGameLabel.topAnchor.constraint(equalTo: stackForRightAndLeftButtons.bottomAnchor, constant: 56),
            gameSpeedSegmentedControl.topAnchor.constraint(equalTo: chooseLevelGameLabel.bottomAnchor, constant: 16),
            gameSpeedSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            gameSpeedSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            gameSpeedSegmentedControl.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        rightButton.addTarget(self, action: #selector(listRight), for: .primaryActionTriggered)
        leftButton.addTarget(self, action: #selector(listLeft), for: .primaryActionTriggered)
    }
    
    func createTapGester() {
        let tapGester = UITapGestureRecognizer(target: self, action: #selector(avatarImageTapped(sender: )))
        avatarImage.addGestureRecognizer(tapGester)
        avatarImage.isUserInteractionEnabled = true
    }
    
    @objc func avatarImageTapped(sender: UITapGestureRecognizer) {
        let alert = UIAlertController(title: "Photo source", message: nil, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
            self.showPicker(source: .camera)
        }
        
        let libraryAction = UIAlertAction(title: "Photo library", style: .default) { _ in
            self.showPicker(source: .photoLibrary)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(cameraAction)
        alert.addAction(libraryAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    
    private func showPicker(source: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = source
        imagePicker.modalPresentationStyle = .fullScreen
        present(imagePicker, animated: true)
    }
    
    func load() {
        var loaded = UserDefaults.standard.object(Settings.self, forKey: Keys.gameSettings)
        if loaded == nil {
            loaded = Settings()
        }
        
        if let currentIndex = loaded?.imageCar {
            self.currentIndex = currentIndex
            imageView.image = arrayOfCars[currentIndex]
        }
        
        if let text = loaded?.nameOfPlayer {
            nameTextField.text = text
        }
        
        if let selectedIndex = loaded?.gameLevel {
            gameSpeedSegmentedControl.selectedSegmentIndex = selectedIndex
        }
        
        if let selectedIndex = loaded?.gameSpeed {
            if let selectedIndexX = GameLevel(rawValue: gameSpeedSegmentedControl.selectedSegmentIndex) {
                var newSpeedGame = selectedIndexX.getSpeed()
                newSpeedGame = selectedIndex
            }
        }
    }
    
    func loadImage() {
        guard let fileName = UserDefaults.standard.object(forKey: Keys.photo) as? String,
              let avatar = DataManager.shared.loadImage(fileName: fileName) else { return }
        print(fileName)
        avatarImage.image = avatar
    }
    
    func saveAvatarImage(image: UIImage) {
        let imageName = DataManager.shared.saveImage(image)
        UserDefaults.standard.set(imageName, forKey: Keys.photo)
    }
    
    func saveUserDefaults() {
        
        var settings = UserDefaults.standard.object(Settings.self, forKey: Keys.gameSettings)
        if settings == nil {
            settings = Settings()
        }
        settings?.imageCar = currentIndex
        
        if let name = nameTextField.text {
            settings?.nameOfPlayer = name
        }
        
        if let selectedIndex = GameLevel(rawValue: gameSpeedSegmentedControl.selectedSegmentIndex) {
            settings?.gameLevel = selectedIndex.rawValue
            settings?.gameSpeed = selectedIndex.getSpeed()
        }
        UserDefaults.standard.set(encodable: settings, forKey: Keys.gameSettings)
    }
    
    
    @objc func goBack() {
        saveUserDefaults()
        navigationController?.popViewController(animated: true)
    }
    
    
    @objc func listLeft() {
        currentIndex -= 1
        if currentIndex >= 0 {
            imageView.image = arrayOfCars[currentIndex]
        }
        if currentIndex < 0 {
            currentIndex = arrayOfCars.count - 1
            imageView.image = arrayOfCars[currentIndex]
        }
    }
    
    @objc func listRight() {
        currentIndex += 1
        if currentIndex < arrayOfCars.count {
            imageView.image = arrayOfCars[currentIndex]
        } else {
            currentIndex = 0
            imageView.image = arrayOfCars[currentIndex]
        }
    }
    
}


extension SettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var chosenImage = UIImage()
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            chosenImage = image
        }
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            chosenImage = image
        }
        avatarImage.image = chosenImage
        saveAvatarImage(image: chosenImage)
        picker.dismiss(animated: true)
    }
}

extension SettingsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if let text = textField.text {
            print("\(text)")
        }
        return true
    }
}


