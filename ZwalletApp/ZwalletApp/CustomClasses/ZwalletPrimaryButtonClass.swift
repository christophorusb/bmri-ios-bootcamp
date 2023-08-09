//
//  ZwalletPrimaryButtonClass.swift
//  ZwalletApp
//
//  Created by laptop MCO on 06/08/23.
//

import UIKit

class ZwalletPrimaryButtonClass: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }

    func setupButton() {
        // Custom Button Style
        self.backgroundColor = UIColor(named: "ZwalletPrimary")
        self.setTitleColor(.white, for: .normal)
        self.layer.cornerRadius = 15
    }
}
