//
//  UserData+CoreDataProperties.swift
//  UnderstandingCoreData
//
//  Created by appinventiv on 23/09/17.
//  Copyright © 2017 yogesh singh negi. All rights reserved.
//
//

import Foundation
import CoreData


extension UserData {

    @nonobjc public class func userDataFetchRequest() -> NSFetchRequest<UserData> {
        return NSFetchRequest<UserData>(entityName: "UserData")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?

}
