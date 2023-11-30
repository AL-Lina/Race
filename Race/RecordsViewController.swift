//
//  RecordsViewController.swift
//  Race
//
//  Created by Alina Sakovskaya on 21.09.23.
//

import UIKit

class RecordsViewController: UIViewController {
    
    
    
//    var dataSource = UserDefaults.standard.object([SettingsForTableView].self, forKey: Keys.settingsForTableView)
    
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
    
    let resultsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "GAME RESULTS"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideNavigationBar()
setUpScreen()
        view.adGradientBackgroundColor(firstColor: .black, secondColor: .purple)
//        objectDate()
        
    }
    
    func setUpScreen() {
        view.addSubview(tableView)
        view.addSubview(resultsLabel)
        view.addSubview(backButton)
        
        backButton.addTarget(self, action: #selector(goBack), for: .primaryActionTriggered)
        
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 6),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            backButton.heightAnchor.constraint(equalToConstant: 30),
            backButton.widthAnchor.constraint(equalToConstant: 50),
            resultsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 6),
            resultsLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 6),
            resultsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: resultsLabel.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(RecordsTableViewCell.self, forCellReuseIdentifier: RecordsTableViewCell.identifier)
    }
    
    
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
}

extension RecordsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecordsTableViewCell.identifier, for: indexPath) as? RecordsTableViewCell else { return UITableViewCell() }
        cell.configure()
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}



