//
//  UIViewControllerUtils.swift
//  bank
//
//  Created by Sunggon Park on 2024/03/25.
//

import UIKit

extension UIViewController {
    func setupStatusBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground()
        navBarAppearance.backgroundColor = CustomColors.appColor
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }
    
    func setupTabBar(title: String, imageName: String, tag: Int) {
        let imageConfiguration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: imageName, withConfiguration: imageConfiguration)
        tabBarItem = UITabBarItem(title: title, image: image, tag: tag)
    }
}
