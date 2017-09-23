//
//  CoreDataManager.swift
//  UnderstandingCoreData
//
//  Created by appinventiv on 23/09/17.
//  Copyright © 2017 yogesh singh negi. All rights reserved.
//

import Foundation
import CoreData
import UIKit

//=============================
//MARK: CoreDataManager class which controls the saving and fetching of the data from the CoreData
//=============================
class CoreDataManager {
    
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    class func save(entity: String,userEnteredData: [String:String]) {
        
        var userData:UserData?
        
        let userDataEntity = NSEntityDescription.entity(forEntityName: entity, in: self.context)
        
        userData = UserData(entity: userDataEntity!, insertInto: self.context)
        
        userData?.firstName = userEnteredData["firstName"]
        userData?.lastName = userEnteredData["lastName"]
        
        do {
            try self.context.save()
        }
        catch {
            print(error)
        }
        
    }
    
    class func singleSearch(searchString: String) -> [String] {
        
        var userDataArray = [String]()
        
        let request = UserData.userDataFetchRequest()
        
        // Searching particular result which matches searchString
        request.predicate = NSPredicate(format: "firstName == %@", searchString)
        
        do {
            let result = try self.context.fetch(request)
            
            // Check whether result has some value or not
            if result.count > 0 {
                for temp in 0..<result.count {
                    let firstName = (result[temp] as AnyObject).value(forKey: "firstName") as! String
                    let lastName = (result[temp] as AnyObject).value(forKey: "lastName") as! String
                    userDataArray.insert(firstName, at: temp)
                    userDataArray[temp] = userDataArray[temp] + " " + lastName
                }
            }
            else {
                userDataArray.append("No User")
            }
        }
        catch {
            print(error)
        }
        return userDataArray
    }
    
    class func fetchAll() ->[UserData] {
        
        var userDataArray:[UserData] = []
        
        do {
            userDataArray = try self.context.fetch(UserData.userDataFetchRequest())
        } catch {
            print(error)
        }
        return userDataArray
    }
    
    class func myDelete(indexPath:IndexPath,deleteElement: UserData) {
        
        self.context.delete(deleteElement)
        
        do {
            try self.context.save()
        } catch {
            print(error)
        }
    }
    
}
