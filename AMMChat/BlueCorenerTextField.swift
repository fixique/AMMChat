//
//  BlueCorenerTextField.swift
//  AMMChat
//
//  Created by Vlad Krupenko on 02.05.17.
//  Copyright © 2017 JaneSV. All rights reserved.
//

import UIKit

@IBDesignable

class BlueCorenerTextField: UITextField {
    
    override func draw(_ rect: CGRect) {
        self.clipsToBounds = true
        self.layer.borderColor = UIColor(red: 62.0/255.0, green: 145.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = self.bounds.height / 2
        
    }
}
