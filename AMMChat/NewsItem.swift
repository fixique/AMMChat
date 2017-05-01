//
//  NewsItem.swift
//  AMMChat
//
//  Created by Vlad Krupenko on 01.05.17.
//  Copyright © 2017 JaneSV. All rights reserved.
//

import Foundation
import UIKit

class NewsItem {
    
    var newsTitle: String
    var newsImage: String
    var newsText: String
    var newsTime: String
    var newsDate: String
    
    init(title: String, image: String, text: String, time: String, date: String) {
        self.newsTitle = title
        self.newsImage = image
        self.newsText = text
        self.newsTime = time
        self.newsDate = date
    }
}
