//
//  NewsDetailVC.swift
//  AMMChat
//
//  Created by Vlad Krupenko on 04.05.17.
//  Copyright © 2017 JaneSV. All rights reserved.
//

import UIKit
import Firebase

class NewsDetailVC: UIViewController {

    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsText: UITextView!
    
    var itemToShow: NewsItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsText.text = itemToShow.newsText
        self.title = itemToShow.newsTitle
        
        if let img = NewsVC.imageCache.object(forKey: itemToShow.newsImage as NSString) {
            self.newsImage.image = img
        } else {
            let ref = FIRStorage.storage().reference(forURL: itemToShow.newsImage)
            ref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in
                if error != nil {
                    print("LOG: Unable to download image from Firebase Storage")
                } else {
                    print("LOG: Image download from Firebase Storage")
                    if let imgData = data {
                        if let img = UIImage(data: imgData) {
                            self.newsImage.image = img
                            NewsVC.imageCache.setObject(img, forKey: self.itemToShow.newsImage as NSString)
                        }
                    }
                }
            })

        }

        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.white,
             NSFontAttributeName: UIFont(name: "AvenirNext-DemiBold", size: 16)!]
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
