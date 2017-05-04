//
//  FindFriendsVC.swift
//  AMMChat
//
//  Created by Vlad Krupenko on 04.05.17.
//  Copyright © 2017 JaneSV. All rights reserved.
//

import UIKit
import Firebase

class FindFriendsVC: MainVC, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var people = [User]()
    var inSearchMode = false

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            tableView.reloadData()
            view.endEditing(true)
        } else {
            inSearchMode = true
            
            let lower = searchBar.text!.lowercased()
            
            DataService.ds.REF_USERS.queryOrdered(byChild: "lowcasename").queryStarting(atValue: lower).queryEnding(atValue: lower + "\u{f8ff}").observe(.value, with: { (snapshot) in
                if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                    self.people.removeAll()
                    for snap in snapshot {
                        let friend = User(snapshot: snap)
                        self.people.append(friend)
                        
                    }
                }
                self.tableView.reloadData()
            })
            
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell") as? searchFriendsCell {
            let firend: User!
            
            if inSearchMode {
                firend = people[indexPath.row]
                cell.configureCell(item: firend)
            }
            
            return cell
        } else {
            return searchFriendsCell()
        }
        
        
//        let news = self.news[indexPath.row]
//        
//        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? NewsItemCell {
//            if let img = NewsVC.imageCache.object(forKey: news.newsImage as NSString) {
//                cell.configureCell(item: news, img: img)
//            } else {
//                cell.configureCell(item: news)
//            }
//            return cell
//        } else {
//            return NewsItemCell()
//        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }



}
