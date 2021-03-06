//
//  MenuVC.swift
//  AMMChat
//
//  Created by Vlad Krupenko on 30.04.17.
//  Copyright © 2017 JaneSV. All rights reserved.
//

import UIKit

class MenuVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var personAvatar: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userCourse: UILabel!
    
    
    var interactor: Interactor? = nil
    
    var menuActionDelegate:MenuActionDelegate? = nil
    
    var menuItems: [MenuItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Делаем аватар пользователя круглым
        personAvatar.layer.cornerRadius = personAvatar.bounds.width / 2
        personAvatar.layer.borderWidth = 1.0
        personAvatar.layer.borderColor = UIColor.white.cgColor
        personAvatar.layer.masksToBounds = true
        // Генерируем пункты меню
        menuItems = generateMenuItems()
        // Готовим таблицу
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if currentUser != nil {
            userName.text = currentUser.userName
            userCourse.text = currentUser.course
            
            if currentUser.avatar != "" {
                if !ProfileVC.userAvatars.isEmpty {
                    personAvatar.image = ProfileVC.userAvatars.last?.image as? UIImage
                }
            }
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MenuCell
        configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
        
        return cell
    }
    
    func configureCell(cell: MenuCell, indexPath: NSIndexPath) {
        
        let item = menuItems[indexPath.row]
        cell.configureCell(item: item)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        menuActionDelegate?.selectTab(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }


    @IBAction func handleGesture(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        let progress = MenuHelper.calculateProgress(translationInView: translation, viewBounds: view.bounds, direction: .Left)
        
        MenuHelper.mapGestureStateToInteractor(
            gestureState: sender.state,
            progress: progress,
            interactor: interactor){
                self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    @IBAction func cancelBtnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    func generateMenuItems() -> [MenuItem] {
        
        var menuItems: [MenuItem] = []
        
        let profile = MenuItem(title: "Мой Профиль", image: #imageLiteral(resourceName: "profile"))
        let friends = MenuItem(title: "Найти друзей", image: #imageLiteral(resourceName: "Friends"))
        let chats = MenuItem(title: "Чаты", image: #imageLiteral(resourceName: "ChatMenu"))
        let news = MenuItem(title: "Новости ПММ", image: #imageLiteral(resourceName: "newsIcon"))
        menuItems.append(profile)
        menuItems.append(news)
        menuItems.append(chats)
        menuItems.append(friends)
        
        return menuItems
    }


}
//extension MenuVC : UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return menuItems.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
//        cell.textLabel?.text = menuItems[indexPath.row]
//        return cell
//    }
//}
//
//extension MenuVC : UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        menuActionDelegate?.selectTab(indexPath.row)
//    }
//}

