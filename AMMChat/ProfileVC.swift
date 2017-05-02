//
//  ProfileVC.swift
//  AMMChat
//
//  Created by Vlad Krupenko on 30.04.17.
//  Copyright © 2017 JaneSV. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class ProfileVC: MainVC {

    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userCourse: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.white,
             NSFontAttributeName: UIFont(name: "AvenirNext-DemiBold", size: 21)!]

    }
    
    @IBAction func logoutBtnPressed(_ sender: Any) {
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        let cancel = UIAlertAction(title: "Отмена", style: .cancel) { (alert: UIAlertAction) in
        
        }
        
        let exit = UIAlertAction(title: "Выход", style: .destructive) { (alert: UIAlertAction) in
            self.logout()
        }
        
        sheet.addAction(exit)
        sheet.addAction(cancel)
        self.present(sheet, animated: true, completion: nil)
    }
    
    func logout() {
        let keychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("LOG: ID removed from keychain \(keychainResult)")
        try! FIRAuth.auth()?.signOut()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let naviVC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = naviVC

    }

    
}
