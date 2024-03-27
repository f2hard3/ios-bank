//
//  ViewController.swift
//  bank
//
//  Created by Sunggon Park on 2024/03/23.
//

import UIKit

protocol LoginViewControllerDelegate: AnyObject {
    
}

class LoginViewController: UIViewController {
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let loginView = LoginView()
    let signInButton = UIButton(type: .system)
    let errorMessageLabel = UILabel()
    let defaults = UserDefaults.standard
    
    var userName: String? {
        loginView.usernameTextField.text
    }
    
    var password: String? {
        loginView.passwordTextField.text
    }
    
    // animation
    var titleLeadingAnchor: NSLayoutConstraint?
    var descriptionLeadingAnchor: NSLayoutConstraint?
    let leadingEdgeOnScreen: CGFloat = 16
    let leadingEdgeOffScreen: CGFloat = -1000
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animate()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        signInButton.configuration?.showsActivityIndicator = false
    }
}

// MARK: - Style and Layout
extension LoginViewController {
    private func style() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.text = "Bank"
        titleLabel.alpha = 0 // for animation
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        descriptionLabel.adjustsFontForContentSizeCategory = true
        descriptionLabel.numberOfLines = 0
        descriptionLabel.text = "Your premium source for all banking services"
        descriptionLabel.alpha = 0 // for animation
        
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configuration = .filled()
        signInButton.configuration?.imagePadding = 8    // for indicator spacing
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.isHidden = true
    }
    
    private func layout() {
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 3),
            titleLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        titleLeadingAnchor = titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
        titleLeadingAnchor?.isActive = true
        
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalToSystemSpacingBelow: descriptionLabel.bottomAnchor, multiplier: 3),
            descriptionLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        descriptionLeadingAnchor = descriptionLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor, constant: leadingEdgeOffScreen)
        descriptionLeadingAnchor?.isActive = true
        
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1),
        ])
        
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2),
            errorMessageLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
        ])
    }
}

// MARK: - Actions
extension LoginViewController {
    @objc private func signInTapped(sender: UIButton) {
        errorMessageLabel.isHidden = true
        view.endEditing(true)
        
        loginView.usernameTextField.text = "Kevin"
        loginView.passwordTextField.text = "Welcome"
        
        login()
    }
    
    private func login() {
        guard let userName = userName, let password = password else {
            assertionFailure("userName and password should never be nil")
            return
        }
        
        if userName.isEmpty || password.isEmpty {
            configureView(withMessage: "username / password cannot be blank")
            shakeButton()
            return
        }
        
        if userName == "Kevin" && password == "Welcome" {
            signInButton.configuration?.showsActivityIndicator = true
            didLogin()
        } else {
            configureView(withMessage: "Incorrect username / password")
            shakeButton()
        }
    }
    
    private func configureView(withMessage message: String) {
        errorMessageLabel.text = message
        errorMessageLabel.isHidden = false
    }
    
    private func didLogin() {
        if LocalState.hasOnboarded {
            let mainViewController = MainViewController()
            mainViewController.modalPresentationStyle = .fullScreen
            
            present(mainViewController, animated: false)
        } else {
            let onboardingContainerController = OnboardingContainerController()
            onboardingContainerController.delegate = self
            onboardingContainerController.modalPresentationStyle = .fullScreen
            
            present(onboardingContainerController, animated: true)
        }
    }
}

// MARK: - OnboardingContainerControllerDelegate
extension LoginViewController: OnboardingContainerControllerDelegate {
    func didFinishOnboarding() {
        LocalState.hasOnboarded = true
        
        let mainViewController = MainViewController()
        mainViewController.modalPresentationStyle = .fullScreen
        
        self.present(mainViewController, animated: false)
    }
}

// MARK: - Animation {
extension LoginViewController {
    private func animate() {
        let duration: TimeInterval = 1
        
        let titleAnchorAnimator = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            self.titleLeadingAnchor?.constant = self.leadingEdgeOnScreen
            
            self.view.layoutIfNeeded()
        }
        titleAnchorAnimator.startAnimation()
        
        let descriptionAnimator = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            self.descriptionLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        descriptionAnimator.startAnimation(afterDelay: 0.25)
        
        let textAnimator = UIViewPropertyAnimator(duration: duration * 2, curve: .easeInOut) {
            self.titleLabel.alpha = 1
            self.descriptionLabel.alpha = 1
            self.view.layoutIfNeeded()
        }
        textAnimator.startAnimation(afterDelay: 0.25)
    }
    
    private func shakeButton() {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0, 10, -10, 10, 0]
        animation.keyTimes = [0, 0.16, 0.5, 0.83, 1]
        animation.duration = 0.4
        animation.isAdditive = true
        
        signInButton.layer.add(animation, forKey: "shake")
    }
}
