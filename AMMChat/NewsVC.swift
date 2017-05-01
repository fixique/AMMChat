//
//  NewsVC.swift
//  AMMChat
//
//  Created by Vlad Krupenko on 01.05.17.
//  Copyright © 2017 JaneSV. All rights reserved.
//

import UIKit

class NewsVC: MainVC, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var news: [NewsItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        news = generateNewsItems()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 330
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsItemCell
        configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
        
        return cell
    }
    
    func configureCell(cell: NewsItemCell, indexPath: NSIndexPath) {
        
        let item = news[indexPath.row]
        cell.configureCell(item: item)
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        menuActionDelegate?.selectTab(indexPath.row)
//    }
//    
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
