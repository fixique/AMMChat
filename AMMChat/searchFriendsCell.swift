//
//  searchFriendsCell.swift
//  AMMChat
//
//  Created by Vlad Krupenko on 05.05.17.
//  Copyright © 2017 JaneSV. All rights reserved.
//

import UIKit
import Firebase

class searchFriendsCell: UITableViewCell {

    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var course: UILabel!
    @IBOutlet weak var addBtn: UIImageView!
    
    var userID: String!
    var addRef: FIRDatabaseReference!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(addTapped))
        tap.numberOfTapsRequired = 1
        addBtn.addGestureRecognizer(tap)
        addBtn.isUserInteractionEnabled = true
    }
    
    func configureCell(item: User, img: UIImage? = nil) {
        name.text = item.userName
        course.text = item.course
        userAvatar.layer.cornerRadius = 55 / 2
        userAvatar.clipsToBounds = true
        userID = item.snapKey
        
        addRef = DataService.ds.REF_FRIENDLIST.child(userID)

        
        if img != nil {
            //TODO: set cache images
        } else {
            let ref = FIRStorage.storage().reference(forURL: item.avatar)
            ref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in
                if error != nil {
                    print("LOG: Unable to download image from Firebase storage")
                } else {
                    print("LOG:: Image download from Firebase storage")
                    if let imgData = data {
                        if let img = UIImage(data: imgData) {
                            self.userAvatar.image = img
                            //TODO: Set image to cache
                        }
                    }
                }
            })
        }
        
        addRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? NSNull {
                self.addBtn.image = #imageLiteral(resourceName: "addFriendBtn")
            } else {
                self.addBtn.image = nil
            }
        })
        
    }
    
    func addTapped(sender: UITapGestureRecognizer) {
        addRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? NSNull {
                self.addBtn.image = nil
                let uid = UUID().uuidString
                DataService.ds.REF_FRIENDLIST.updateChildValues([self.userID : self.userID])
                DataService.ds.REF_FRIENDLIST_ALL.child(self.userID).updateChildValues([currentUser.snapKey : currentUser.snapKey])
                DataService.ds.REF_CHANNELS.child(uid).updateChildValues(["messages" : ""])
                DataService.ds.REF_USERCHATS.child(currentUser.snapKey).child(uid).updateChildValues(["secondUser" : self.userID])
                DataService.ds.REF_USERCHATS.child(self.userID).child(uid).updateChildValues(["secondUser" : currentUser.snapKey])
            } else {
                self.addBtn.image = #imageLiteral(resourceName: "addFriendBtn")
                
            }
        })

        
        
//        DataService.ds.REF_FRIENDLIST
//        let frID = NSUUID().uuidString
//        DataService.ds.REF_FRIENDLIST.setValue([frID : userID])
//        addBtn.image = nil
    }

    
    

}
