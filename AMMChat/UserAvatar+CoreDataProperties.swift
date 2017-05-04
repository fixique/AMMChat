//
//  UserAvatar+CoreDataProperties.swift
//  AMMChat
//
//  Created by Vlad Krupenko on 04.05.17.
//  Copyright © 2017 JaneSV. All rights reserved.
//

import Foundation
import CoreData


extension UserAvatar {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserAvatar> {
        return NSFetchRequest<UserAvatar>(entityName: "UserAvatar")
    }

    @NSManaged public var image: NSObject?

}
