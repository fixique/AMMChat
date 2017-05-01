//
//  NewsItemCell.swift
//  AMMChat
//
//  Created by Vlad Krupenko on 01.05.17.
//  Copyright © 2017 JaneSV. All rights reserved.
//

import UIKit

class NewsItemCell: UITableViewCell {

    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTIme: UILabel!
    @IBOutlet weak var newsDate: UILabel!
    
    func configureCell(item: NewsItem) {
        newsTitle.text = item.newsTitle
        newsTIme.text = item.newsTime
        newsDate.text = item.newsDate
    }
    
    
    
}
