//
//  NewsItemCell.swift
//  AMMChat
//
//  Created by Vlad Krupenko on 01.05.17.
//  Copyright © 2017 JaneSV. All rights reserved.
//

import UIKit
import Firebase

class NewsItemCell: UITableViewCell {

    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTIme: UILabel!
    @IBOutlet weak var newsDate: UILabel!
    
    func configureCell(item: NewsItem, img: UIImage? = nil) {
        newsTitle.text = item.newsTitle
        newsTIme.text = item.newsTime
        newsDate.text = item.newsDate
        
        if img != nil {
            self.newsImage.image = img
        } else {
            let ref = FIRStorage.storage().reference(forURL: item.newsImage)
            ref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in
                if error != nil {
                    print("LOG: Unable to download image from Firebase Storage")
                } else {
                    print("LOG: Image download from Firebase Storage")
                    if let imgData = data {
                        if let img = UIImage(data: imgData) {
                            self.newsImage.image = img
                            NewsVC.imageCache.setObject(img, forKey: item.newsImage as NSString)
                        }
                    }
                }
            })
        }
        

    }
    
    
    
}
