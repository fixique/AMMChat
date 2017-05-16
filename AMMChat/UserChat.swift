//
//  UserChat.swift
//  AMMChat
//
//  Created by Vlad Krupenko on 16.05.17.
//  Copyright © 2017 JaneSV. All rights reserved.
//

import Foundation

class UserChat {
    var secondUserId: String
    var id: String
    
    init(id: String, userId: String) {
        self.id = id
        self.secondUserId = userId
    }
}
