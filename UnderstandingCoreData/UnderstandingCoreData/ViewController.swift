//
//  ViewController.swift
//  UnderstandingCoreData
//
//  Created by appinventiv on 19/09/17.
//  Copyright © 2017 yogesh singh negi. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var userDataArray = [String]()
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var searchUser: UITextField!
    
    @IBOutlet weak var showUserDataTable: UITableView!
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showUserDataTable.delegate = self
        self.showUserDataTable.dataSource = self
        
        let cell = UINib(nibName: "CustomCell", bundle: nil)
        self.showUserDataTable.register(cell, forCellReuseIdentifier: "CustomCell_ID")
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.searchUser.text = ""
        self.userDataArray.removeAll()
        self.showUserDataTable.reloadData()
        
    }
    
    @IBAction func saveUserBtnTapped(_ sender: UIButton) {
        
        if self.firstName.text != "" && self.lastName.text != "" {
            
            let newUserData = NSEntityDescription.insertNewObject(forEntityName: "UserData", into: self.context)
            
            newUserData.setValue(self.firstName.text!, forKey: "firstName")
            newUserData.setValue(self.lastName.text!, forKey: "lastName")
            
            do {
                try context.save()
            }
            catch {
                print(error)
            }
            
            self.myAlert(title: "Insertion Done", message: "User Data has been inserted successfully", actionTitle: "OK")
            
            self.firstName.text = ""
            self.lastName.text = ""
            
        }
        else {
            
            self.myAlert(title: "Empty Field", message: "Field(s) cannot be left empty", actionTitle: "OK")
          
        }
        
    }
    
    @IBAction func searchUserBtnTapped(_ sender: UIButton) {
        
        self.userDataArray.removeAll()
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserData")
        
        request.predicate = NSPredicate(format: "firstName == %@", self.searchUser.text!)
        
        do {
            let result = try context.fetch(request)
            if result.count > 0 {
                for temp in 0..<result.count {
                    let firstName = (result[temp] as AnyObject).value(forKey: "firstName") as! String
                    let lastName = (result[temp] as AnyObject).value(forKey: "lastName") as! String
                    self.userDataArray.insert(firstName, at: temp)
                    self.userDataArray[temp] = self.userDataArray[temp] + " " + lastName
                    print(firstName,lastName)
                }
            }
            else {
                self.userDataArray.insert("No User", at: 0)
            }
        }
        catch {
            print(error)
        }
        self.showUserDataTable.reloadSections([0], with: .automatic)
    }
    
    func myAlert(title:String,message:String,actionTitle:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: actionTitle, style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    

}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell_ID") as? CustomCell else {
            fatalError("Cell Failed to load")
        }
        
        cell.showData.text = self.userDataArray[indexPath.row]
        
        return cell
    }
    
    
    
}

