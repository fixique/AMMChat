//
//  User.swift
//  AMMChat
//
//  Created by Vlad Krupenko on 03.05.17.
//  Copyright © 2017 JaneSV. All rights reserved.
//

import Foundation
import Firebase

class User {
    var userName: String
    var lowcasename: String
    var course: String
    var avatar: String
    var provider: String
    
    init(name: String, course: String, avatar: String, provider: String, lowcasename: String) {
        self.userName = name
        self.lowcasename = lowcasename
        self.course = course
        self.avatar = avatar
        self.provider = provider
    }
    
    init(snapshot: FIRDataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        self.userName = snapshotValue["username"] as! String
        self.lowcasename = snapshotValue["lowcasename"] as! String
        self.course = snapshotValue["course"] as! String
        self.avatar = snapshotValue["avatar"] as! String
        self.provider = snapshotValue["provider"] as! String
    }
    
    func toAnyObject() -> Any {
        return ["username" : self.userName,
                "lowcasename" : self.lowcasename,
                "course" : self.course,
                "avatar" : self.avatar,
                "provider" : self.provider
        ]
    }
    
}
