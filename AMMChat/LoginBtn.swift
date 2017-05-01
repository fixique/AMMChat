//
//  LoginBtn.swift
//  AMMChat
//
//  Created by Vlad Krupenko on 02.05.17.
//  Copyright © 2017 JaneSV. All rights reserved.
//

import UIKit
@IBDesignable

class LoginBtn: UIButton {

    override func draw(_ rect: CGRect) {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.bounds.height / 2
        self.layer.backgroundColor = UIColor.white.cgColor
    }
    

}
