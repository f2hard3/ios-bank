//
//  OnboardingContainerController.swift
//  bank
//
//  Created by Sunggon Park on 2024/03/25.
//

import UIKit

protocol OnboardingContainerControllerDelegate: AnyObject {
    func didFinishOnboarding()
}

class OnboardingContainerController: UIViewController {
    private let pageViewController: UIPageViewController
    private var pages = [UIViewController]()
    private var currentVC: UIViewController {
        didSet {
           setupViews()
        }
    }
    private let closeButton = UIButton()
    private let backButton = UIButton()
    private let nextButton = UIButton()
    
    weak var delegate: OnboardingContainerControllerDelegate?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        let page1 = OnboardingViewController(imageName: "delorean", labelText: "Bank is faster, easier to use, and has a brand new look and feel that will make you feel like you are back in 1989")
        let page2 = OnboardingViewController(imageName: "thumbs", labelText: "Move your money around the world quickly and securely")
        let page3 = OnboardingViewController(imageName: "world", labelText: "Learn more at www.bank.com.")
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        currentVC = pages.first!
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
    }
    
    private func style() {
        view.backgroundColor = .systemPurple
        
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        pageViewController.dataSource = self
        pageViewController.delegate = self
        pageViewController.setViewControllers([pages.first!], direction: .forward, animated: false)
        currentVC = pages.first!
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.configuration = .borderless()
        closeButton.setTitle("Close", for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .primaryActionTriggered)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.configuration = .borderless()
        backButton.setTitle("Back", for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .primaryActionTriggered)
        backButton.isHidden = true
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.configuration = .borderless()
        nextButton.setTitle("Next", for: .normal)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .primaryActionTriggered)
    }
        
    private func layout() {
        addChild(pageViewController)
        pageViewController.didMove(toParent: self)
        
        view.addSubview(pageViewController.view)
        view.addSubview(closeButton)
        view.addSubview(backButton)
        view.addSubview(nextButton)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: pageViewController.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: pageViewController.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: pageViewController.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: pageViewController.view.bottomAnchor),
            
            closeButton.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
            closeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: backButton.bottomAnchor, multiplier: 4),
            backButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            
            nextButton.topAnchor.constraint(equalTo: backButton.topAnchor),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: nextButton.trailingAnchor, multiplier: 1)
        ])
    }
}

// MARK: - UIPageViewController
extension OnboardingContainerController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return getPreviousViewController(from: viewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return getNextViewController(from: viewController)
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        setupViews()
    }
    

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return pages.firstIndex(of: currentVC) ?? 0
    }
    
    private func getPreviousViewController(from viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController), currentIndex - 1 >= 0 else { return nil }
        currentVC = pages[currentIndex - 1]
        
        return currentVC
    }
    
    private func getNextViewController(from viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController), currentIndex + 1 < pages.count else { return nil }
        currentVC = pages[currentIndex + 1]
        
        return currentVC
    }
}

// MARK: - actions
extension OnboardingContainerController {
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc private func backButtonTapped() {
        guard let previousVC = getPreviousViewController(from: currentVC) else { return }
        pageViewController.setViewControllers([previousVC], direction: .reverse, animated: true) { _ in
            self.currentVC = previousVC
        }
    }
    
    @objc private func nextButtonTapped() {
        guard let currentIndex = pages.firstIndex(of: currentVC) else { return }
        
        // Next button Becomes Done button and will finish the onboarding
        if currentIndex == 2 {
            dismiss(animated: false)
            delegate?.didFinishOnboarding()
        }
        
        guard let nextVC = getNextViewController(from: currentVC) else { return }
        pageViewController.setViewControllers([nextVC], direction: .forward, animated: true) { _ in
            self.currentVC = nextVC
        }
    }
    
    private func setupViews() {
        guard let currentVC = pageViewController.viewControllers?.first else { return }
        guard let currentIndex = pages.firstIndex(of: currentVC) else { return }
        
        if currentIndex ==  0 {
            backButton.isHidden = true
            nextButton.setTitle("Next", for: .normal)
        } else if currentIndex == 1 {
            backButton.isHidden = false
            nextButton.setTitle("Next", for: .normal)
        } else {
            backButton.isHidden = false
            nextButton.setTitle("Done", for: .normal)
        }
    }
}
