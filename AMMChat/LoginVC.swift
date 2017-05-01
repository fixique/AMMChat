//
//  LoginVC.swift
//  AMMChat
//
//  Created by Vlad Krupenko on 02.05.17.
//  Copyright © 2017 JaneSV. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var emailTextField: LoginTextField!
    @IBOutlet weak var passwordTextField: LoginTextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Делегируем все наши текстовые поля, чтобы работать с клавиатурой
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapMethod))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(singleTapGestureRecognizer)

    }
    
    func tapMethod(sender: UITapGestureRecognizer) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        self.view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 200), animated: true)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTage = textField.tag + 1
        let nextResponder = textField.superview?.viewWithTag(nextTage) as UIResponder!
        
        if nextResponder != nil {
            nextResponder?.becomeFirstResponder()
        } else {
            self.view.endEditing(true)
        }
        
        return true
    }
    
    
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        
    }

 
}
