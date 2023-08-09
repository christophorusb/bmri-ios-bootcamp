//
//  ViewController.swift
//  ZwalletApp
//
//  Created by laptop MCO on 03/08/23.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //var secureTextEntryHelper: CustomUIBuilder.SecureTextEntryHelper?
        
        let shadowView = createShadowRectView()
        let roundedRectView = createRoundRectView(withFrame: shadowView.bounds)
        let loginHeaderLabel = createHeaderTypeLabel(withText: "Login")
        let loginSubHeaderLabel = createSubHeaderTypeLabel(withText: "Login to your existing account to access \nall the features in Zwallet")
        
        // Create a stack view that contains a header and a sub-header
        let loginHeaderStackView = UIStackView(arrangedSubviews: [loginHeaderLabel, loginSubHeaderLabel])
        loginHeaderStackView.axis = .vertical
        loginHeaderStackView.distribution = .fillProportionally
        loginHeaderStackView.spacing = 10
        loginHeaderStackView.translatesAutoresizingMaskIntoConstraints = false
        loginHeaderStackView.isLayoutMarginsRelativeArrangement = true
        loginHeaderStackView.layoutMargins = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
        
        // Create the form
        let emailField = createTextField(placeholder: "Email", systemIconName: "envelope")
        let passwordField = createTextField(placeholder: "Password", isSecureTextEntry: true, systemIconName: "lock")
        let formFieldsStackView = UIStackView(arrangedSubviews: [emailField, passwordField])
        formFieldsStackView.axis = .vertical
        formFieldsStackView.distribution = .fillProportionally
        formFieldsStackView.spacing = 50
        formFieldsStackView.translatesAutoresizingMaskIntoConstraints = false
        formFieldsStackView.isLayoutMarginsRelativeArrangement = true
        formFieldsStackView.layoutMargins = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        emailField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        passwordField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // Create the forgot password label
        let forgotPasswordText = UILabel()
        forgotPasswordText.text = "Forgot Password?"
        forgotPasswordText.textColor = UIColor.black
        forgotPasswordText.isUserInteractionEnabled = true
        forgotPasswordText.translatesAutoresizingMaskIntoConstraints = false
        forgotPasswordText.font = UIFont.systemFont(ofSize: 12)
        forgotPasswordText.textAlignment = .right
        
        
        // Create the Login Button
        
        let loginButton = UIButton(type: .system)
        loginButton.heightAnchor.constraint(equalToConstant: 57).isActive = true
        loginButton.backgroundColor = UIColor(named: "ZwalletPrimary")
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 10
        loginButton.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        // Create the "Don't have an account?" message and the Sign Up NavLink
        let signUpMessageAttribute = NSMutableAttributedString(
            string: "Don't have an account? ",
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14.0),
                NSAttributedString.Key.foregroundColor: UIColor.gray
            ]
        )
        
        signUpMessageAttribute.append(NSAttributedString(
            string: "Sign Up",
            attributes: [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14.0),
                NSAttributedString.Key.foregroundColor: UIColor.blue
            ]
        ))
        
        let signUpMessageLabel = UILabel()
        signUpMessageLabel.attributedText = signUpMessageAttribute
        signUpMessageLabel.isUserInteractionEnabled = true
        signUpMessageLabel.textAlignment = .center
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(signUpLabelTapped))
        signUpMessageLabel.addGestureRecognizer(tapGestureRecognizer)
        
        
        // Create the main stack and add all of the previous components
        let mainStackView = UIStackView(arrangedSubviews: [loginHeaderStackView, formFieldsStackView, forgotPasswordText, loginButton, signUpMessageLabel])
        mainStackView.axis = .vertical
        mainStackView.distribution = .fill
        mainStackView.spacing = 10
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.setCustomSpacing(30, after: forgotPasswordText)
        mainStackView.setCustomSpacing(20, after: loginButton)
        
        roundedRectView.addSubview(mainStackView)
        
        // Add the roundedRectView to the shadowView
        shadowView.addSubview(roundedRectView)

        // Add the shadowView to the main view
        view.addSubview(shadowView)
        
        /*
            IMPORTANT to set the constraints of the main stack view AFTER adding the mainStackVew
            to the screen / parent view
         */
        mainStackView.topAnchor.constraint(equalTo: roundedRectView.layoutMarginsGuide.topAnchor).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: roundedRectView.layoutMarginsGuide.leadingAnchor).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: roundedRectView.layoutMarginsGuide.trailingAnchor).isActive = true
        mainStackView.bottomAnchor.constraint(lessThanOrEqualTo: roundedRectView.layoutMarginsGuide.bottomAnchor).isActive = true
    }
    
    // Function to create shadow for the rounded rectangle view
    func createShadowRectView() -> UIView {
        // Set block height to be half of the screen
        let blockHeight = UIScreen.main.bounds.height / 1.5

        // Create a new UIView to display the shadow
        let shadowView = UIView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height - blockHeight, width: UIScreen.main.bounds.width, height: blockHeight))
        shadowView.backgroundColor = .clear
        
        // Configure the shadow
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.backgroundColor = .clear
        shadowView.layer.shadowOffset = CGSize(width: 0, height: -3)
        shadowView.layer.shadowOpacity = 0.1
        shadowView.layer.shadowRadius = 40
        
        return shadowView
    }
    
    // Function to create the rounded rectangle view
    func createRoundRectView(withFrame frame: CGRect) -> UIView {
        // Create a new UIView for the rounded rectangle
        let roundedRectView = UIView(frame: frame)
        roundedRectView.backgroundColor = UIColor.white
        roundedRectView.layer.cornerRadius = 40
        roundedRectView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        roundedRectView.clipsToBounds = true
        return roundedRectView
    }
    
    // Declare a function to create header type label
    func createHeaderTypeLabel(withText text: String) -> UILabel {
        
        let label = UILabel()
        label.text = text
        
        label.textColor = UIColor.black
        
//        label.textColor = isUsingCustomColor == true ? UIColor(named: customColorSetName ?? "ZwalletDefault") : UIColor(hex: textColorHex ?? "000000")
        
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        
        return label
    }
    
    // Declare a function to create sub-header type label
    func createSubHeaderTypeLabel(withText text: String) -> UILabel{
        
        let label = UILabel()
        label.text = text
//        label.textColor = isUsingCustomColor == true ? UIColor(named: customColorSetName ?? "ZwalletFontSecondarySubColor") : UIColor(hex: textColorHex ?? "000000")
        label.textColor = UIColor(named: "ZwalletDefault")
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }
    
    func createTextField(placeholder: String, isSecureTextEntry: Bool = false, systemIconName: String? = nil) -> UITextField {
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
            let button = UIButton(type: .custom)
            button.setImage(UIImage(systemName: "eye"), for: .normal)
            button.tintColor = UIColor(named: "ZwalletPrimary")
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
            button.frame = CGRect(x: CGFloat(textField.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
            button.addTarget(self, action: #selector(self.togglePasswordVisibility), for: .touchUpInside)
            textField.rightView = button
            textField.rightViewMode = .whileEditing
        }

        textField.delegate = self

        return textField
    }
    
    /*
        ==============================================================================
        | BEHAVIORS, ACTIONS                                                         |
        ==============================================================================
     */
    
    @objc func togglePasswordVisibility(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if let textField = sender.superview as? UITextField {
            textField.isSecureTextEntry = !sender.isSelected
            sender.setImage(UIImage(systemName: sender.isSelected ? "eye.slash" : "eye"), for: .normal)
        }
    }
    
    @objc func loginButtonTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let nextViewController = storyboard.instantiateViewController(withIdentifier: "OTPVerificationViewController") as? OTPVerificationViewController{
            navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
    
    @objc func signUpLabelTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let targetViewController = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        navigationController?.setViewControllers([targetViewController], animated: true)
    }

    /*
        ==============================================================================
        | DELEGATE REQUIRED METHODS
        ==============================================================================
     */
    
    // UITextField Delegate Methods
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Change the color of the bottom border when the text field is active
        if let customTextField = textField as? ZwalletCustomTextField{
            customTextField.bottomLine.backgroundColor = UIColor(named: "ZwalletPrimary")?.cgColor
            //customTextField.bottomLine.backgroundColor = UIColor.gray.cgColor
            customTextField.textColor = UIColor(named: "ZwalletPrimary")
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Change the color of the bottom border back when the text field is inactive
        if let customTextField = textField as? ZwalletCustomTextField {
            customTextField.bottomLine.backgroundColor = UIColor.gray.cgColor
            customTextField.textColor = UIColor.black
        }
    }
}
