//
//  NewsVC.swift
//  AMMChat
//
//  Created by Vlad Krupenko on 01.05.17.
//  Copyright © 2017 JaneSV. All rights reserved.
//

import UIKit
import Firebase

class NewsVC: MainVC, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    static var imageCache: NSCache<NSString, UIImage> = NSCache()
    var news = [NewsItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        news = generateNewsItems()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 330
        
        DataService.ds.REF_NEWS.observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                self.news.removeAll()
                for snap in snapshot {
                    print("SNAP: \(snap)")
                    if let newsDict = snap.value as? Dictionary<String, Any> {
                        let key = snap.key
                        let news = NewsItem(postKey: key, postData: newsDict)
                        self.news.append(news)
                    }
                }
            }
            self.news = self.news.reversed()
            self.tableView.reloadData()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.white,
             NSFontAttributeName: UIFont(name: "AvenirNext-DemiBold", size: 21)!]
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let news = self.news[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? NewsItemCell {
            if let img = NewsVC.imageCache.object(forKey: news.newsImage as NSString) {
                cell.configureCell(item: news, img: img)
            } else {
                cell.configureCell(item: news)
            }
            return cell
        } else {
            return NewsItemCell()
        }
    }
    
//    func configureCell(cell: NewsItemCell, indexPath: NSIndexPath) {
//        
//        let item = news[indexPath.row]
//        cell.configureCell(item: item)
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if news.count > 0 {
            
            let item = news[indexPath.row]
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newsDetailVC = mainStoryboard.instantiateViewController(withIdentifier: "NewsDetailVC") as! NewsDetailVC
            newsDetailVC.itemToShow = item
            self.navigationController?.pushViewController(newsDetailVC, animated: true)
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        if segue.identifier == "NewsDetailVC" {
//            if let destination = segue.destination as? NewsDetailVC {
//                if let item = sender as? NewsItem {
//                    destination.itemToShow = item
//                }
//            }
//        }
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func generateNewsItems() -> [NewsItem] {
        
        var newsItems: [NewsItem] = []
        
        let item1 = NewsItem(title: "На ПММ Весна", image: "", text: "Команда студентов ПММ заняла 1 место на конкурсе весны ВГУ. Мы очень гордимся нашими студентами. За эти достижения декан факультета ПММ выебет их в зад", time: "13:05", date: "25 Марта 2017")
        let item2 = NewsItem(title: "На ПММ Весна", image: "", text: "Команда студентов ПММ заняла 1", time: "13:05", date: "25 Марта 2017")
        let item3 = NewsItem(title: "На ПММ Весна", image: "", text: "Команда студентов ПММ заняла 1 место на конкурсе весны ВГУ. Мы очень гордимся нашими студентами. За эти достижения декан факультета ПММ выебет их в зад", time: "13:05", date: "25 Марта 2017")
        let item4 = NewsItem(title: "На ПММ Весна", image: "", text: "Команда студентов ПММ заняла 1 место на конкурсе весны ВГУ. Мы очень гордимся нашими студентами. За эти достижения декан факультета ПММ выебет их в зад", time: "13:05", date: "25 Марта 2017")
        newsItems.append(item1)
        newsItems.append(item2)
        newsItems.append(item3)
        newsItems.append(item4)
        
        return newsItems
    }

    
    
}
