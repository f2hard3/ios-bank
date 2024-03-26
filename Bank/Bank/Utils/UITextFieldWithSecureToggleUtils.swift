//
//  UITextFieldWithSecureToggle.swift
//  Bank
//
//  Created by Sunggon Park on 2024/03/27.
//

import UIKit

extension UITextField {
    func enablePasswordToggle() {
        let passwordToggleButton = UIButton(type: .custom)
        passwordToggleButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        passwordToggleButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .selected)
        passwordToggleButton.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        rightView = passwordToggleButton
        rightViewMode = .always
    }
    
    @objc private func togglePasswordView(_ sender: UIButton) {
        isSecureTextEntry.toggle()
        sender.isSelected.toggle()
    }
}
