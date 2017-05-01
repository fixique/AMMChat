//
//  MenuCell.swift
//  AMMChat
//
//  Created by Vlad Krupenko on 01.05.17.
//  Copyright © 2017 JaneSV. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {

    
    @IBOutlet weak var menuItemImg: UIImageView!
    @IBOutlet weak var menuItemTitle: UILabel!
    
    func configureCell(item: MenuItem) {
        menuItemTitle.text = item.title
        menuItemImg.image = item.image
    }

    
}
