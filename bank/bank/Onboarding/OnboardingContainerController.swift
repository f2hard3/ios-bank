//
//  OnboardingContainerController.swift
//  bank
//
//  Created by Sunggon Park on 2024/03/25.
//

import UIKit

class OnboardingContainerController: UIViewController {
    private let pageViewController: UIPageViewController
    private var pages = [UIViewController]()
    private var currentVC: UIViewController {
        didSet {
            
        }
    }
    
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
        
        view.backgroundColor = .systemPurple
        
        setupPageViewController()
    }
    
    private func setupPageViewController() {
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        pageViewController.dataSource = self
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: pageViewController.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: pageViewController.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: pageViewController.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: pageViewController.view.bottomAnchor),
        ])
        
        pageViewController.setViewControllers([pages.first!], direction: .forward, animated: false)
        currentVC = pages.first!
    }
    
    private func setupPages() {
        
    }
}

// MARK: UIPageViewController
extension OnboardingContainerController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return getPreviousViewController(from: viewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return getNextViewController(from: viewController)
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

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return pages.firstIndex(of: currentVC) ?? 0
    }
}

extension OnboardingContainerController: OnboardingViewControllerDelegate {
    func closeButtonTapped() {
        
    }
    
    func nextButtonTapped() {
        
    }
    
    
}
