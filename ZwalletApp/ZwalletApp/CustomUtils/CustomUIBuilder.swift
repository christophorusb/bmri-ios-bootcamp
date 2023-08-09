//
//  CustomUIBuilder.swift
//  ZwalletApp
//
//  Created by laptop MCO on 05/08/23.
//

import Foundation
import UIKit

struct CustomUIBuilder{
    /*
    Important: The helper instance needs to be kept alive as long as the text field is alive. In this example, we simply create an instance and discard it. The helper class keeps a strong reference to the text field, which in turn keeps a strong reference to the right view button, which has a target-action relationship with the helper, ensuring that the helper isn't deallocated prematurely. However, in a more complex scenario, you might want to ensure you keep a reference to the helper to avoid deallocation.
     */
    class SecureTextEntryHelper: NSObject{
        let textField: UITextField
                
        init(textField: UITextField) {
            self.textField = textField
            super.init()
            setup()
        }
        
        deinit {
            print("Helper deallocated!")
        }

        
        private func setup() {
            let button = UIButton(type: .custom)
            button.setImage(UIImage(systemName: "eye"), for: .normal)
            button.tintColor = UIColor(named: "ZwalletPrimary")
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
            button.frame = CGRect(x: CGFloat(textField.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
            button.addTarget(self, action: #selector(self.toggleVisibility), for: .touchUpInside)
            textField.rightView = button
            textField.rightViewMode = .whileEditing
        }
        
//        @objc private func toggleVisibility(_ sender: UIButton) {
//            sender.isSelected = !sender.isSelected
//            if let textField = sender.superview as? UITextField {
//                textField.isSecureTextEntry = !sender.isSelected
//                sender.setImage(UIImage(systemName: sender.isSelected ? "eye.slash" : "eye"), for: .normal)
//            }
//        }
//
        @objc func toggleVisibility() {
            textField.isSecureTextEntry.toggle()
            let imageName = textField.isSecureTextEntry ? "eye.fill" : "eye.slash.fill"
            if let button = textField.rightView as? UIButton {
                button.setImage(UIImage(systemName: imageName), for: .normal)
            }
        }
    }
    
    static func createZwalletCustomTextField(addPlaceholder placeholder: String, isFieldSecureTextEntry isSecureTextEntry: Bool = false, usingSystemIconName systemIconName: String? = nil) -> UITextField {
        let textField = ZwalletCustomTextField()
        
        // Configure text field
        textField.placeholder = placeholder
        textField.isSecureTextEntry = isSecureTextEntry
        textField.borderStyle = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        
        if let systemIconName = systemIconName {
            let iconView = UIImageView(image: UIImage(systemName: systemIconName))
            iconView.contentMode = .scaleAspectFit
            iconView.tintColor = UIColor(named: "ZwalletPrimary")
            let iconContainerView: UIView = UIView(frame: CGRect(x: 20, y: 0, width: 50, height: 30))
            iconView.frame = CGRect(x: 10, y: 5, width: 20, height: 20)
            iconContainerView.addSubview(iconView)
            textField.leftView = iconContainerView
            textField.leftViewMode = .always
        }

        if isSecureTextEntry {
            let _ = SecureTextEntryHelper(textField: textField)
        }
        
        //textField.delegate = self
        
        return textField
    }
}


