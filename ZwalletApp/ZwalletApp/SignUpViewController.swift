//
//  SignUpViewController.swift
//  ZwalletApp
//
//  Created by laptop MCO on 06/08/23.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var roundedCard: UIView!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var HeadersContainer: UIView!
    @IBOutlet weak var SignUpFormContainer: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        let mainHeader = createMainHeader(forText: "Sign Up")
        let subHeader = createSubHeader(forText: "Create your account to access Zwallet")
        HeadersContainer.addSubview(mainHeader)
        HeadersContainer.addSubview(subHeader)
        
        let nameField = createTextField(placeholder: "Name", systemIconName: "person")
        let emailField = createTextField(placeholder: "Email", systemIconName: "envelope")
        let passwordField = createTextField(placeholder: "Password", isSecureTextEntry: true, systemIconName: "lock")
        
        SignUpFormContainer.addArrangedSubview(nameField)
        SignUpFormContainer.addArrangedSubview(emailField)
        SignUpFormContainer.addArrangedSubview(passwordField)

        
        // Center the first label horizontally and vertically
        NSLayoutConstraint.activate([
            mainHeader.centerXAnchor.constraint(equalTo: HeadersContainer.centerXAnchor),
//            mainHeader.centerYAnchor.constraint(equalTo: HeadersContainer.centerYAnchor)
        ])
//
        // Center the second label horizontally and position it below the first label
        NSLayoutConstraint.activate([
            subHeader.centerXAnchor.constraint(equalTo: HeadersContainer.centerXAnchor),
            subHeader.topAnchor.constraint(equalTo: mainHeader.bottomAnchor, constant: 20),
            subHeader.leadingAnchor.constraint(equalTo: HeadersContainer.leadingAnchor),
            subHeader.trailingAnchor.constraint(equalTo: HeadersContainer.trailingAnchor),
        ])
    }
    
    func initialSetup(){
        roundedCard.applyShadowedRoundedCard()
        signUpButton.applyRoundedCornersToButton()
    }
    
    func createMainHeader(forText text: String) -> UILabel {
        let mainHeader = UILabel()
        mainHeader.text = text
        mainHeader.font = UIFont.boldSystemFont(ofSize: 24)
        mainHeader.translatesAutoresizingMaskIntoConstraints = false
        
        return mainHeader
    }
    
    func createSubHeader(forText text: String) -> UILabel {
        let subHeader = UILabel()
        subHeader.text = text
        subHeader.textColor = UIColor(named: "ZwalletDefault")
        subHeader.font = UIFont.systemFont(ofSize: 14)
        subHeader.translatesAutoresizingMaskIntoConstraints = false
        subHeader.textAlignment = .center
        subHeader.numberOfLines = 0
        subHeader.lineBreakMode = .byWordWrapping
        
        return subHeader
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
            button.addTarget(self, action: #selector(self.toggleVisibility), for: .touchUpInside)
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
    
    @objc func toggleVisibility(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if let textField = sender.superview as? UITextField {
            textField.isSecureTextEntry = !sender.isSelected
            sender.setImage(UIImage(systemName: sender.isSelected ? "eye.slash" : "eye"), for: .normal)
        }
    }
    
    /*
        ==============================================================================
        | DELEGATE REQUIRED METHODS                                                  |
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
