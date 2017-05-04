//
//  LoginVC.swift
//  AMMChat
//
//  Created by Vlad Krupenko on 02.05.17.
//  Copyright © 2017 JaneSV. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

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
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            print("LOG: ID found in keychain. View presented by LoginVC")
            performSegue(withIdentifier: "goToChat", sender: nil)
        }
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
        guard emailTextField.text != "", passwordTextField.text != "" else {
        
            let alertController = UIAlertController(title: "Ошибка", message: "Пожалуйста введите email и пароль", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
            return
        }
        
        if let email = emailTextField.text, let pwd = passwordTextField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error == nil {
                    print("LOG: Email user authenticated with Firebase")
                    if let user = user {
                        let userData = ["provider": user.providerID]
                        self.completeSignIn(id: user.uid, userData: userData, status: false)
                    }
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil {
                            let alertController = UIAlertController(title: "Ошибка", message: "Неудалось зарегистрировать пользователя", preferredStyle: .alert)
                            let defaultAction = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
                            alertController.addAction(defaultAction)
                            self.present(alertController, animated: true, completion: nil)
                        } else {
                            print("LOG: Successfuly authenticated with firebase")
                            if let user = user {
                                let userData = ["provider": user.providerID,
                                                "username": "Нет имени(",
                                                "course": "1 курс 1 группа",
                                                "avatar": "",
                                                "lowcasename" : "нет имени("]
                                self.completeSignIn(id: user.uid, userData: userData, status: true)
                            }
                        }
                    })
                }
            })
        }
        
    }
    
    func completeSignIn(id: String, userData: Dictionary<String, String>, status: Bool) {
        if status {
            DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
        }
        let keychainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("LOG: Data saved to keychain \(keychainResult)")
        performSegue(withIdentifier: "goToChat", sender: nil)
    }

 
}


























