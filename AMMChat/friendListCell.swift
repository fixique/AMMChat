//
//  friendListCell.swift
//  AMMChat
//
//  Created by Vlad Krupenko on 05.05.17.
//  Copyright © 2017 JaneSV. All rights reserved.
//

import UIKit
import Firebase

class friendListCell: UITableViewCell {

    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userCourse: UILabel!
    

    func configureCell(item: User, img: UIImage? = nil) {
        userName.text = item.userName
        userCourse.text = item.course
        userAvatar.layer.cornerRadius = 55 / 2
        userAvatar.clipsToBounds = true
        
        
        
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
        
    }
    

}
