//
//  Constants.swift
//  AMMChat
//
//  Created by Vlad Krupenko on 02.05.17.
//  Copyright © 2017 JaneSV. All rights reserved.
//

import Foundation
import CoreData

var currentUser: User!
let KEY_UID = "uid"

func deleteAllData(_ entity: String) {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
    fetchRequest.returnsObjectsAsFaults = false
    
    do {
        let results = try context.fetch(fetchRequest)
        for managedObject in results {
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            context.delete(managedObjectData)
            ad.saveContext()
        }
    } catch let error as NSError {
        print("Detele all data in \(entity) error : \(error) \(error.userInfo)")
    }
}

let courses = ["1 курс 1 группа",
               "1 курс 2 группа",
               "1 курс 3 группа",
               "1 курс 4 группа",
               "1 курс 5 группа",
               "1 курс 6 группа",
               "1 курс 10 группа",
               "1 курс 21 группа",
               "1 курс 61 группа",
               "1 курс 62 группа",
               "1 курс 71 группа",
               "1 курс 9 группа",
               "1 курс 91 группа",
               "2 курс 1 группа",
               "2 курс 2 группа",
               "2 курс 3 группа",
               "2 курс 4 группа",
               "2 курс 5 группа",
               "2 курс 10 группа",
               "2 курс 21 группа",
               "2 курс 61 группа",
               "2 курс 71 группа",
               "2 курс 72 группа",
               "2 курс 9 группа",
               "3 курс 1 группа",
               "3 курс 3 группа",
               "3 курс 4 группа",
               "3 курс 5 группа",
               "3 курс 6 группа",
               "3 курс 7 группа",
               "3 курс 8 группа",
               "3 курс 9 группа",
               "3 курс 10 группа",
               "3 курс 21 группа",
               "3 курс 61 группа",
               "3 курс 71 группа",
               "3 курс 72 группа",
               "3 курс 91 группа",
               "4 курс 1 группа",
               "4 курс 3 группа",
               "4 курс 4 группа",
               "4 курс 5 группа",
               "4 курс 6 группа",
               "4 курс 7 группа",
               "4 курс 8 группа",
               "4 курс 9 группа",
               "4 курс 21 группа",
               "4 курс 61 группа",
               "4 курс 62 группа",
               "4 курс 71 группа",
               "4 курс 72 группа",
               "4 курс 91 группа"]
