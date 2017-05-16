//
//  ChatsVC.swift
//  AMMChat
//
//  Created by Vlad Krupenko on 04.05.17.
//  Copyright © 2017 JaneSV. All rights reserved.
//

import UIKit
import Firebase

class ChatsVC: MainVC, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var serviceHandle: FIRDatabaseHandle?
    
    var chats = [UserChat]()
    var users = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        serviceHandle = DataService.ds.REF_USERCHATS.child(currentUser.snapKey).observe(.value, with: { (snapshot) in
            if snapshot.exists() {
                self.chats.removeAll()
                self.users.removeAll()
                if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                    for snap in snapshot {
                        if let dict = snap.value as? Dictionary<String, Any> {
                            let key = snap.key
                            let userId = dict["secondUser"] as! String
                            let chat = UserChat(id: key, userId: userId)
                            self.chats.append(chat)
                            DataService.ds.REF_USERS.child(userId).observeSingleEvent(of: .value, with: { (snapshot) in
                                if snapshot.exists() {
                                    let user = User(snapshot: snapshot)
                                    self.self.users.append(user)
                                    self.self.tableView.reloadData()
                                }
                            })
                        }
                    }
                }
            }
        })

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        if let refHandle = serviceHandle {
            DataService.ds.REF_USERCHATS.child(currentUser.snapKey).removeObserver(withHandle: refHandle)
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let user = self.users[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "chatFriendCell") as? ChatFriendCell {
            if let img = ProfileVC.imageCache.object(forKey: user.avatar as NSString) {
                cell.configureCell(item: user, img: img)
            } else {
                cell.configureCell(item: user)
            }
            return cell
        } else {
            return ChatFriendCell()
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = chats[indexPath.row]
        let user = users[indexPath.row]
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let chatVC = mainStoryboard.instantiateViewController(withIdentifier: "ChatView") as! UserChatVC
        chatVC.secondUser = user
        chatVC.channel = item
        self.navigationController?.pushViewController(chatVC, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
}
