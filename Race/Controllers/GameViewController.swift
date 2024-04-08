//
//  ViewController.swift
//  Race
//
//  Created by Alina Sakovskaya on 18.08.23.
//

import UIKit

class GameViewController: UIViewController {
    
    let stopWatchLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "00 : 00 : 00"
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .white
        label.shadowColor = .black
        return label
    }()
    
    let arrayOfCars = [UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "3"), UIImage(named: "4"), UIImage(named: "5")]
    
    let firstBackgroundImageView = UIImageView(image: UIImage(named: "road"))
    let secondBackgroundImageView = UIImageView(image: UIImage(named: "road"))
    
    let obstacleImageView = UIImageView(image: UIImage(named: "obstacle"))
    let carImageView = UIImageView(image: UIImage(named: "1"))
    
    var arrayOfObstacle: [UIImageView] = []
    
    var blur = UIBlurEffect()
    var blurEffect = UIVisualEffectView()
    
    
    var timerForStopwatch: Timer = Timer()
    var count: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let timer = Timer.scheduledTimer(timeInterval: 1.4, target: self, selector: #selector(spawnFallingObjects), userInfo: nil, repeats: true)
        
        let secondTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(intersects), userInfo: nil, repeats: true)
        
        timerForStopwatch = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        
        addPanGesture()
        objectData()
    }
    
    func setUpScreen() {
        
        view.addSubview(stopWatchLabel)
        self.hideNavigationBar()
        
        NSLayoutConstraint.activate([
            stopWatchLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            stopWatchLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12)
        ])
        createBlurEffect()
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func timerCounter() -> Void {
        count = count + 1
        let time = secondsToHoursMinutesSeconds(seconds: count)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        stopWatchLabel.text = timeString
    }
    
    func createBlurEffect() {
        blur = UIBlurEffect(style: UIBlurEffect.Style.dark)
        blurEffect = UIVisualEffectView(effect: blur)
        blurEffect.frame = view.bounds
        blurEffect.isHidden = true
        view.addSubview(blurEffect)
    }
    
    
    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int) {
        return ((seconds / 3600), ((seconds % 3600) / 60), ((seconds % 3600) % 60))
    }
    
    func makeTimeString(hours: Int, minutes: Int, seconds: Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += " : "
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
        return timeString
    }
    
    func pauseLayer(layer: CALayer) {
        let pausedTime: CFTimeInterval = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0.0
        layer.timeOffset = pausedTime
    }
    
    func resumeLayer(layer: CALayer) {
        let pausedTime: CFTimeInterval = layer.timeOffset
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        let timeSincePause: CFTimeInterval = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layer.beginTime = timeSincePause
    }
    
    
    func createCar() {
        view.addSubview(carImageView)
        carImageView.frame = CGRect(x: Int(view.center.x), y: Int (view.frame.size.height - 200), width: 100, height: 140)
    }
    
    func addPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(moveCar(gesture: )))
        carImageView.isUserInteractionEnabled = true
        carImageView.addGestureRecognizer(panGesture)
    }
    
    @objc func moveCar(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        
        let newX = translation.x + carImageView.center.x
        let newY = carImageView.center.y
        
        carImageView.center = CGPoint(x: newX, y: newY)
        
        gesture.setTranslation(CGPoint.zero, in: self.view)
    }
    
    func objectData() {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        let date = dateFormatter.string(from: currentDate)
        
        if let gameSettings = UserDefaults.standard.object(Settings.self, forKey: Keys.gameSettings) {
            carImageView.image = arrayOfCars[gameSettings.imageCar]
            createBackgroundRoad(withDuration: gameSettings.gameSpeed)
            gameSettings.date = date
        }
    }
    
    func createBackgroundRoad(withDuration: Double) {
        firstBackgroundImageView.frame = CGRect(x: self.view.frame.origin.x,
                                                y: self.view.frame.origin.y,
                                                width: self.view.frame.size.width,
                                                height: self.view.frame.size.height)
        view.addSubview(firstBackgroundImageView)
        
        secondBackgroundImageView.frame = CGRect(x: self.view.frame.origin.x,
                                                 y: -firstBackgroundImageView.frame.size.height,
                                                 width: self.view.frame.size.width,
                                                 height: self.view.frame.size.height)
        view.addSubview(secondBackgroundImageView)
        
        UIView.animate(withDuration: withDuration, delay: 0.3, options: [.repeat, .curveLinear]) {
            self.firstBackgroundImageView.frame = CGRectOffset(self.firstBackgroundImageView.frame, 0.0, 1 * self.firstBackgroundImageView.frame.size.height)
            self.secondBackgroundImageView.frame = CGRectOffset(self.secondBackgroundImageView.frame, 0.0, 1 * self.secondBackgroundImageView.frame.size.height)
        }
        createCar()
        createObstacle()
        setUpScreen()
    }
    
    
    func createObstacle() {
        let coordinateX = view.frame.minX - 80
        let coordinateY = view.frame.minY - 120
        
        obstacleImageView.frame.size = CGSize(width: 80, height: 120)
        obstacleImageView.frame.origin = CGPoint(x: coordinateX, y: coordinateY)
        view.addSubview(obstacleImageView)
        arrayOfObstacle.append(obstacleImageView)
    }
    
    @objc func intersects() {
        for view in arrayOfObstacle {
            let element = view.layer.presentation()
            if let elementFrame = element?.frame {
                if elementFrame.intersects(carImageView.frame) {
                    timerForStopwatch.invalidate()
                    if let text = stopWatchLabel.text {
                        showAlert(title: "Ooops! 🙄 ", message: "Your game time: \(text)")
                    }
                    view.removeFromSuperview()
                    self.pauseLayer(layer: self.obstacleImageView.layer)
                }
            }
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let tryAction = UIAlertAction(title: "TRY AGAIN", style: .default) { _ in
            self.count = 0
            self.stopWatchLabel.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
            self.timerForStopwatch = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.timerCounter), userInfo: nil, repeats: true)
            self.objectData()
            self.resumeLayer(layer: self.obstacleImageView.layer)
        }
        
        let backButton = UIAlertAction(title: "GO TO MENU", style: .cancel) {_ in
            self.navigationController?.popViewController(animated: true)
            self.objectData()
        }
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) {
            self.view.frame.origin.x = 0
            self.blurEffect.isHidden = false }
        alert.addAction(tryAction)
        alert.addAction(backButton)
        present(alert, animated: true)
    }
    
    
    @objc func spawnFallingObjects() {
        let firstLength = view.frame.minX
        let secondLength = view.frame.maxX - 90
        let startedY = view.frame.minY - 200
        
        let randomXPosition = Int.random(in: Int(firstLength)...Int(secondLength))
        obstacleImageView.frame.origin = CGPoint(x: randomXPosition, y: Int(startedY))
        
        UIView.animate(withDuration: 1.6) {
            self.obstacleImageView.frame.origin.y = CGFloat(self.view.frame.maxY)
        }
    }
}
