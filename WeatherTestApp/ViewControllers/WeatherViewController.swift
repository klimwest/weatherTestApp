//
//  WeatherViewController.swift
//  WeatherTestApp
//
//  Created by West on 26.02.23.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    //MARK: - Properties
    
    private lazy var dataLabel: UILabel = {
        let label = UILabel()
        label.tintColor = .systemBlue
        label.font = UIFont(name: "DamascusBold", size: 50)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "third")
        return imageView
    }()
    
    var coordinator: AppCoordinator?
    var location: CLLocationCoordinate2D?
    
    let localStorage = LocalStorageService()
    
    //MARK: - Init
    
    init(location: CLLocationCoordinate2D?) {
        self.location = location
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        if localStorage.getTutorialStatus() {
            getLocation()
        } else {
            getWeather(location: location ?? CLLocationCoordinate2D())
            localStorage.saveTutorialStatus(status: true)
        }
    }
    
    //MARK: - Private
    
    private func setupUI() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        view.addSubview(dataLabel)
        view.addSubview(imageView)
        setupConstraints()
    }
    
    private func getLocation() {
        LocationService.shared.getUserLocation { [weak self] location in
            self?.getWeather(location: location?.coordinate ?? CLLocationCoordinate2D())
        }
    }
    
    private func getWeather(location: CLLocationCoordinate2D) {
        HUD.show()
        NetworkService.shared.getWeather(location: location) { [weak self] weather in
            DispatchQueue.main.async {
                self?.dataLabel.text = "\(weather.location?.name ?? ""), \(weather.current?.temp_c ?? 0)°"
                
                HUD.hide()
            }
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            dataLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dataLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            dataLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: dataLabel.centerXAnchor),
            imageView.bottomAnchor.constraint(equalTo: dataLabel.topAnchor, constant: -10),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            imageView.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
}
