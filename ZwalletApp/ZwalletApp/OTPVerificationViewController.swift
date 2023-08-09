//
//  OTPVerificationViewController.swift
//  ZwalletApp
//
//  Created by laptop MCO on 06/08/23.
//

import UIKit
import QuartzCore

class OTPVerificationViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var roundedCard: UIView!
    
    @IBOutlet weak var HeadersContainer: UIView!
    
    @IBOutlet weak var OTPFieldsHorizontalStackContainer: UIStackView!
    
    @IBOutlet weak var confirmButton: UIButton!
    
    var otpTextFields: [UITextField] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
        
        let mainHeader = createMainHeader(forText: "Create Security PIN")
        let subHeader = createSubHeader(forText: "Create a PIN that’s contain 6 digits number for \nsecurity purpose in Zwallet.")
        HeadersContainer.addSubview(mainHeader)
        HeadersContainer.addSubview(subHeader)
        
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
        
        setupOTPFields()
    }
    
    func initialSetup(){
        roundedCard.applyShadowedRoundedCard()
        confirmButton.applyRoundedCornersToButton()
        confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
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
    
    func createOTPTextField() -> UITextField {
        let textField = UITextField()
        textField.delegate = self
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 1.0
        textField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        textField.layer.borderColor = UIColor(named: "ZwalletPrimary")?.cgColor
        textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        textField.widthAnchor.constraint(equalToConstant: 50).isActive = true
        return textField
    }
    
    func setupOTPFields() {
        for _ in 0..<6 {
            let textField = createOTPTextField()
            otpTextFields.append(textField)
            OTPFieldsHorizontalStackContainer.addArrangedSubview(textField)
        }
    }
    
    @objc func textDidChange(_ textField: UITextField) {
        let text = textField.text ?? ""
        
        if text.count == 1 {
            // Focus the next text field
            let nextIndex = otpTextFields.firstIndex(of: textField)! + 1
            if nextIndex < otpTextFields.count {
                otpTextFields[nextIndex].becomeFirstResponder()
            } else {
                // Last field, close the keyboard and get the OTP value
                textField.resignFirstResponder()
                let otp = otpTextFields.map { $0.text ?? "" }.joined()
                print("OTP Value is:", otp)
            }
        } else if text.count == 0 {
            // User deleted, focus the previous text field
            let prevIndex = otpTextFields.firstIndex(of: textField)! - 1
            if prevIndex >= 0 {
                otpTextFields[prevIndex].becomeFirstResponder()
            }
        }
    }
    
    @objc func confirmButtonTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let nextViewController = storyboard.instantiateViewController(withIdentifier: "OTPSuccessViewController") as? OTPSuccessViewController{
            navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
}
