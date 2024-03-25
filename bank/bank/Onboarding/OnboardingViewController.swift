//
//  OnboardingViewController.swift
//  bank
//
//  Created by Sunggon Park on 2024/03/25.
//

import UIKit

@objc protocol OnboardingViewControllerDelegate {
    func closeButtonTapped()
    func nextButtonTapped()
}

class OnboardingViewController: UIViewController {
    private let stackView = UIStackView()
    private let imageView = UIImageView()
    private let descriptionLabel: UILabel = UILabel()
    
    private let imageName: String
    private let labelText: String
    
    private let closeButton = UIButton()
    private let nextButton = UIButton()
    
    var delegate: OnboardingViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
    }
    
    init(imageName: String, labelText: String, delegate: OnboardingViewControllerDelegate? = nil) {
        self.imageName = imageName
        self.labelText = labelText
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func style() {
        view.backgroundColor = .systemBackground
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: imageName)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        descriptionLabel.adjustsFontForContentSizeCategory = true
        descriptionLabel.numberOfLines = 0
        descriptionLabel.text = labelText
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setTitle("Close", for: .normal)
        closeButton.addTarget(self, action: #selector(delegate?.closeButtonTapped), for: .touchUpInside)
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setTitle("Next", for: .normal)
        nextButton.addTarget(self, action: #selector(delegate?.nextButtonTapped), for: .touchUpInside)
    }
    
    private func layout() {        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(descriptionLabel)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1)
//
//            closeButton.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 1),
//            closeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
//            
//            view.bottomAnchor.constraint(equalToSystemSpacingBelow: nextButton.bottomAnchor, multiplier: 1),
//            view.trailingAnchor.constraint(equalToSystemSpacingAfter: nextButton.trailingAnchor, multiplier: 1)
        ])
        
        
    }
}
