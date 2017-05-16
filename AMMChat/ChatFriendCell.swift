//
//  ChatFriendCell.swift
//  AMMChat
//
//  Created by Vlad Krupenko on 16.05.17.
//  Copyright © 2017 JaneSV. All rights reserved.
//

import UIKit
import Firebase

class ChatFriendCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    
    func configureCell(item: User, img: UIImage? = nil) {
        titleLabel.text = item.userName
        userImage.layer.cornerRadius = 55 / 2
        userImage.clipsToBounds = true
        
        if img != nil {
            self.userImage.image = img
        } else {
            let ref = FIRStorage.storage().reference(forURL: item.avatar)
            ref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in
                if error != nil {
                    print("LOG: Unable to download image from Firebase storage")
                } else {
                    print("LOG:: Image download from Firebase storage")
                    if let imgData = data {
                        if let img = UIImage(data: imgData) {
                            self.userImage.image = img
                            ProfileVC.imageCache.setObject(img, forKey: item.avatar as NSString)
                        }
                    }
                }
            })
        }
        
    }

}
