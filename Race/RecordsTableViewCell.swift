//
//  RecordsTableViewCell.swift
//  Race
//
//  Created by Alina Sakovskaya on 27.09.23.
//

import UIKit

class RecordsTableViewCell: UITableViewCell {
    
    static var identifier: String {"\(Self.self)"}
    
    let imageуView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let labelForName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    let labelForStopwatch: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    let labelForDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    let stackForPerson: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    let stackForStopWatchAndDate: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        contentView.addSubview(stackForPerson)
        contentView.addSubview(stackForStopWatchAndDate)
        stackForPerson.addArrangedSubview(imageуView)
        stackForPerson.addArrangedSubview(labelForName)
        stackForStopWatchAndDate.addArrangedSubview(labelForStopwatch)
        stackForStopWatchAndDate.addArrangedSubview(labelForDate)
        
        NSLayoutConstraint.activate([
            stackForPerson.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackForPerson.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackForStopWatchAndDate.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackForStopWatchAndDate.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            imageуView.heightAnchor.constraint(equalToConstant: 60),
            imageуView.widthAnchor.constraint(equalToConstant: 60)
        ])
        
    }
    
    override func prepareForReuse() {
        labelForName.text = nil
        labelForStopwatch.text = nil
        imageуView.image = nil
        labelForDate.text = nil
    }
    
    func configure() {
        guard let gameSettings = UserDefaults.standard.object(Settings.self, forKey: Keys.gameSettings) else { return }
        self.labelForName.text = gameSettings.nameOfPlayer
    }
    
    
}
