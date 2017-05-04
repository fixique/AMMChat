//
//  DataService.swift
//  AMMChat
//
//  Created by Vlad Krupenko on 02.05.17.
//  Copyright © 2017 JaneSV. All rights reserved.
//

import Foundation
import Firebase
import SwiftKeychainWrapper

let DB_BASE = FIRDatabase.database().reference()
let STORAGE_BASE = FIRStorage.storage().reference()

class DataService {
    
    static let ds = DataService()
    

    // DB references
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_NEWS = DB_BASE.child("news")
    
    // Storage references
    private var _REF_STORAGE_BASE = FIRStorage.storage()
    private var _REF_TO_USER_AVATARS = STORAGE_BASE.child("avatars")
    private var _REF_TO_POST_IMAGES = STORAGE_BASE.child("news")
    
    var REF_BASE: FIRDatabaseReference {
        return _REF_BASE
    }
    
    var REF_USERS: FIRDatabaseReference {
        return _REF_USERS
    }
    
    var REF_USER_CURRENT: FIRDatabaseReference {
        let uid = KeychainWrapper.standard.string(forKey: KEY_UID)
        let user = REF_USERS.child(uid!)
        return user
    }
    
    var REF_NEWS: FIRDatabaseReference {
        return _REF_NEWS
    }
    
    var REF_TO_SAVE_AVATAR: FIRStorageReference {
        let uid = KeychainWrapper.standard.string(forKey: KEY_UID)
        let path = _REF_TO_USER_AVATARS.child(uid!)
        return path
    }
    
    var REF_USER_AVATAR: FIRStorageReference {
        
        return _REF_STORAGE_BASE.reference(forURL: currentUser.avatar)
    }
    
    var REF_NEWS_IMAGES: FIRStorageReference {
        return _REF_TO_POST_IMAGES
    }
    
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String, String>){
        REF_USERS.child(uid).updateChildValues(userData)
    }
}
