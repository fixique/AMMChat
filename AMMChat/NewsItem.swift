//
//  NewsItem.swift
//  AMMChat
//
//  Created by Vlad Krupenko on 01.05.17.
//  Copyright © 2017 JaneSV. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class NewsItem {
    
    private var _newsTitle: String!
    private var _newsImage: String!
    private var _newsText: String!
    private var _newsTime: String!
    private var _newsDate: String!
    private var _postKey: String!
    private var _postRef: FIRDatabaseReference!
    
    var newsTitle: String {
        return _newsTitle
    }
    
    var newsText: String {
        return _newsText
    }
    
    var newsTime: String {
        return _newsTime
    }
    
    var newsDate: String {
        return _newsDate
    }
    
    var newsImage: String {
        return _newsImage
    }
    
    
    init(title: String, image: String, text: String, time: String, date: String) {
        self._newsTitle = title
        self._newsImage = image
        self._newsText = text
        self._newsTime = time
        self._newsDate = date
    }
    
    init(postKey: String, postData: Dictionary<String, Any>) {
        self._postKey = postKey
        
        if let newsTitle = postData["title"] as? String {
            self._newsTitle = newsTitle
        }
        
        if let newsText = postData["text"] as? String {
            self._newsText = newsText
        }
        
        if let newsTime = postData["time"] as? String {
            self._newsTime = newsTime
        }
        
        if let newsDate = postData["date"] as? String {
            self._newsDate = newsDate
        }
        
        if let newsImage = postData["img"] as? String {
            self._newsImage = newsImage
        }
        
        _postRef = DataService.ds.REF_NEWS.child(_postKey)
    }
    
    
}
