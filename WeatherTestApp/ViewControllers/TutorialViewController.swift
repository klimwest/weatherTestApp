//
//  TutorialViewController.swift
//  WeatherTestApp
//
//  Created by West on 26.02.23.
//

import UIKit
import CoreLocation

class TutorialViewController: UIPageViewController {
    
    //MARK: - Properties
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.isHidden = true
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var skipButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.isHidden = true
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = .systemBlue
        pageControl.pageIndicatorTintColor = .systemGray
        pageControl.isUserInteractionEnabled = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    var pages = [UIViewController]()
    var coordinator: AppCoordinator?
    var location: CLLocationCoordinate2D?
    
    let localStorage = LocalStorageService()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupPageController()
        getUserLocationResponse()
    }
    
    //MARK: - Actions
    
    @objc private func nextButtonTapped() {
        pageControl.currentPage += 1
        skipButton.isHidden = false
        nextButton.isHidden = true
        setViewControllers([pages[1]], direction: .forward, animated: true, completion: nil)
    }
    
    @objc private func skipButtonTapped() {
        coordinator?.goToWeatherScreen(location: location ?? CLLocationCoordinate2D())
    }
    
    //MARK: - Private
    
    private func setupPageController() {
        let page1 = TutorialScreen(imageName: "first")
        let page2 = TutorialScreen(imageName: "second")
        pages.append(page1)
        pages.append(page2)
        pageControl.numberOfPages = pages.count
        setViewControllers([pages[0]], direction: .forward, animated: true, completion: nil)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(nextButton)
        view.addSubview(skipButton)
        view.addSubview(pageControl)
        setupConstraints()
    }
    
    private func getUserLocationResponse() {
        LocationService.shared.getUserLocation { [weak self] location in
            guard let location = location else {
                return
            }
            self?.location = location.coordinate
            self?.nextButton.isHidden = false
            
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            nextButton.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        NSLayoutConstraint.activate([
            skipButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            skipButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            skipButton.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: nextButton.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -20)
        ])
    }
}

