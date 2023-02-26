//
//  LoaderViewController.swift
//  WeatherTestApp
//
//  Created by West on 26.02.23.
//

import UIKit

class LoaderViewController: UIViewController {
    
    //MARK: - Properties
    
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .systemBlue
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    var coordinator: AppCoordinator?

    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Private
    
    private func setupUI() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        view.addSubview(spinner)
        spinner.startAnimating()
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
