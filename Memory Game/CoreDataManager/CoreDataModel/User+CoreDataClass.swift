//
//  User+CoreDataClass.swift
//  Memory Game
//
//  Created by Andrii Pyvovarov on 3/19/19.
//  Copyright © 2019 AndriiPp. All rights reserved.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject {
    convenience init() {
        self.init(entity: CoreDataManager.sharedInstance.entityForName(entityName: "User"), insertInto: CoreDataManager.sharedInstance.managedObjectContext)
    }
}
