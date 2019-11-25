//
//  User+CoreDataProperties.swift
//  Memory Game
//
//  Created by Andrii Pyvovarov on 3/19/19.
//  Copyright © 2019 AndriiPp. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var endDate: NSDate?
    @NSManaged public var name: String?
    @NSManaged public var score: Int16
    @NSManaged public var startDate: NSDate?

}
