//
//  OTPSuccessViewController.swift
//  ZwalletApp
//
//  Created by laptop MCO on 08/08/23.
//

import UIKit

class OTPSuccessViewController: UIViewController {

    @IBOutlet weak var OTPSuccessMessageWrapper: UIView!
    
    @IBOutlet weak var roundedCard: UIView!
    
    @IBOutlet weak var loginNowButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetup()
        
        let mainHeader = createMainHeader(forText: "PIN Successfully Created")
        let subHeader = createSubHeader(forText: "Your PIN was successfully created and you can now access all the features in Zwallet. Login to your new account and start exploring!")
        OTPSuccessMessageWrapper.addSubview(mainHeader)
        OTPSuccessMessageWrapper.addSubview(subHeader)
        
        // Center the first label horizontally and vertically
        NSLayoutConstraint.activate([
            mainHeader.centerXAnchor.constraint(equalTo: OTPSuccessMessageWrapper.centerXAnchor),
           //mainHeader.centerYAnchor.constraint(equalTo: HeadersContainer.centerYAnchor)
        ])

        // Center the second label horizontally and position it below the first label
        NSLayoutConstraint.activate([
            subHeader.centerXAnchor.constraint(equalTo: OTPSuccessMessageWrapper.centerXAnchor),
            subHeader.topAnchor.constraint(equalTo: mainHeader.bottomAnchor, constant: 20),
            subHeader.leadingAnchor.constraint(equalTo: OTPSuccessMessageWrapper.leadingAnchor),
            subHeader.trailingAnchor.constraint(equalTo: OTPSuccessMessageWrapper.trailingAnchor),
        ])
    }
    
    func initialSetup(){
        roundedCard.applyShadowedRoundedCard()
        loginNowButton.applyRoundedCornersToButton()
        loginNowButton.addTarget(self, action: #selector(loginNowButtonTapped), for: .touchUpInside)
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
    
    @objc func loginNowButtonTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let targetViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        navigationController?.setViewControllers([targetViewController], animated: true)
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
