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

class ProfileVC: MainVC, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userCourse: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    static var userAvatars: [UserAvatar] = []
    var firendsList = [User]()
    var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    var layer: UIView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        userAvatar.layer.cornerRadius = 189 / 2
        userAvatar.clipsToBounds = true
        
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.white,
             NSFontAttributeName: UIFont(name: "AvenirNext-DemiBold", size: 21)!]

        activityIndicator.frame = CGRect(x: self.view.bounds.width / 2 - 25.0, y: self.view.bounds.height / 2 - 50.0, width: 50.0, height: 50.0);
        layer = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        layer.backgroundColor = UIColor(red: 62.0/255.0, green: 144.0/255.0, blue: 252.0/255.0, alpha: 1)
        layer.layer.opacity = 0.8
        layer.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        self.view.addSubview(layer)
        
//        DataService.ds.REF_FRIENDLIST.observe(.value, with: { (snapshot) in
//            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
//                self.firendsList.removeAll()
//                for snap in snapshot {
//                    let friend = User(snapshot: snap)
//                    self.firendsList.append(friend)
//                }
//            }
//            self.tableView.reloadData()
//        })

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if currentUser == nil {
            DataService.ds.REF_USER_CURRENT.observe(.value, with: { (snapshot) in
                if snapshot.exists() {
                    currentUser = User(snapshot: snapshot)
                    self.updateUI()
                    self.activityIndicator.stopAnimating()
                    self.layer.removeFromSuperview()
                    self.downloadImg()
                }
            })
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let friend = self.firendsList[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "friendlistCell") as? friendListCell {
            cell.configureCell(item: friend)
            
            return cell
        } else {
            return friendListCell()
        }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return firendsList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
    
    func updateUI() {
        if currentUser != nil {
            userName.text = currentUser.userName
            userCourse.text = currentUser.course
        }
    }
    
    func downloadImg() {
        guard currentUser.avatar != "" else {
            userAvatar.image = #imageLiteral(resourceName: "emptyAvatar")
            
            return
        }
        
        DataService.ds.REF_USER_AVATAR.data(withMaxSize: 1 * 1024 * 1024) { (data, error) in
            if error != nil {
                print("LOG: Unable to download image from Firebase storage")
            } else {
                print("LOG: Image download from Firebase storage")
                if let imgData = data {
                    if let img = UIImage(data: imgData) {
                        deleteAllData("UserAvatar")
                        ProfileVC.userAvatars.removeAll()
                        let imageD = UserAvatar(context: context)
                        imageD.image = img
                        ad.saveContext()
                        self.getData()
                        self.userAvatar.image = ProfileVC.userAvatars.last?.image as? UIImage
                    }
                }
            }
        }
    }
    
    func getData() {
        do {
            ProfileVC.userAvatars = try context.fetch(UserAvatar.fetchRequest())
        } catch {
            print("LOG: Fetching user avatar faild")
        }
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
        deleteAllData("UserAvatar")
        currentUser = nil
        ProfileVC.userAvatars.removeAll()
        try! FIRAuth.auth()?.signOut()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let naviVC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = naviVC

    }

    
}
