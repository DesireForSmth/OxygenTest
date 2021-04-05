//
//  MainViewController.swift
//  OxygenTest
//
//  Created by Александр Сетров on 05.04.2021.
//

import UIKit

class MainViewController: UIViewController {

    private struct Constants {
        static let buttonOffset: CGFloat = 10
        static let viewLayoutOffset: CGFloat = 16
        static let cornerRadius: CGFloat = 10
        static let fontSize: CGFloat = 30
    }

    var viewModel: MainViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setupDataFetching()
        self.setupUI()
    }

    private func setupDataFetching() {
        self.viewModel?.modelName = { [ weak self ] model in
            self?.modelLabel.text = model
            self?.view.layoutIfNeeded()
        }

        self.viewModel?.systemVersion = { [ weak self ] version in
            self?.systemVersionLabel.text = version
            self?.view.layoutIfNeeded()
        }
    }

    lazy private var buttonBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy private var modelLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy private var systemVersionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy private var fetchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Запустить", for: .normal)
        button.tintColor = .black
        button.titleLabel?.font = UIFont.systemFont(ofSize: Constants.fontSize)
        button.addTarget(self, action: #selector(fetchDeviceInfoData), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    @objc func fetchDeviceInfoData() {
        self.viewModel?.fetchSystemInfo()
    }

    private func setupUI() {
        self.view.addSubview(self.buttonBackground)
        self.buttonBackground.addSubview(self.fetchButton)
        self.view.addSubview(self.modelLabel)
        self.view.addSubview(self.systemVersionLabel)
        self.setupConstraints()
        self.buttonBackground.layer.cornerRadius = Constants.cornerRadius
        self.view.layoutIfNeeded()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.buttonBackground.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.buttonBackground.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),

            self.fetchButton.topAnchor.constraint(equalTo: self.buttonBackground.topAnchor, constant: Constants.buttonOffset),
            self.fetchButton.leadingAnchor.constraint(equalTo: self.buttonBackground.leadingAnchor, constant: Constants.buttonOffset),
            self.fetchButton.trailingAnchor.constraint(equalTo: self.buttonBackground.trailingAnchor, constant: -Constants.buttonOffset),
            self.fetchButton.bottomAnchor.constraint(equalTo: self.buttonBackground.bottomAnchor, constant: -Constants.buttonOffset),

            self.modelLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),

            self.systemVersionLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.systemVersionLabel.topAnchor.constraint(equalTo: self.modelLabel.bottomAnchor, constant: Constants.viewLayoutOffset),
            self.systemVersionLabel.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.viewLayoutOffset)
        ])
    }

    
}
