//
//  LoginTextField.swift
//  AMMChat
//
//  Created by Vlad Krupenko on 02.05.17.
//  Copyright © 2017 JaneSV. All rights reserved.
//

import UIKit
@IBDesignable

class LoginTextField: UITextField {

    
    override func draw(_ rect: CGRect) {
        self.clipsToBounds = true
        self.layer.backgroundColor = UIColor.clear.cgColor
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = self.bounds.height / 2
        if self.tag == 1 {
            self.attributedPlaceholder = NSAttributedString(string: "Email", attributes:[NSForegroundColorAttributeName: UIColor.white] )
        } else if tag == 2 {
            self.attributedPlaceholder = NSAttributedString(string: "Password", attributes:[NSForegroundColorAttributeName: UIColor.white] )
        }
    }
    

}
