//
//  MainViewController.swift
//  bank
//
//  Created by Sunggon Park on 2024/03/25.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupTabBar()
        setupStatusBar()
        
        registerForNotification()
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        
        let accountSummaryVC = AccountSummaryViewController()
        let moveMoneyVC = MoveMoneyViewController()
        let moreVC = MoreViewController()
        
        accountSummaryVC.setupTabBar(title: "Summary", imageName: "list.dash.header.rectangle", tag: 0)
        moveMoneyVC.setupTabBar(title: "Move Money", imageName: "arrow.left.arrow.right", tag: 1)
        moreVC.setupTabBar(title: "More", imageName: "ellipsis.circle", tag: 2)
        
        let accountSummaryNC = UINavigationController(rootViewController: accountSummaryVC)
        let moveMoneyNC = UINavigationController(rootViewController: moveMoneyVC)
        let moreNC = UINavigationController(rootViewController: moreVC)
        
        accountSummaryNC.navigationBar.tintColor = CustomColors.appColor
        
        viewControllers = [accountSummaryNC, moveMoneyNC, moreNC]        
    }
    
    private func setupTabBar() {
        tabBar.tintColor = CustomColors.appColor
        tabBar.isTranslucent = false
    }
    
    private func registerForNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(didLogout), name: .logout, object: nil)
    }
}

// MARK: - Actions
extension MainViewController {
    @objc private func didLogout() {
        dismiss(animated: true)
    }
}
