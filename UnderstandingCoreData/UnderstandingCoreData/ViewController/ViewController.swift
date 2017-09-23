//
//  ViewController.swift
//  UnderstandingCoreData
//
//  Created by appinventiv on 19/09/17.
//  Copyright © 2017 yogesh singh negi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var userDataArray = [String]()
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var searchUser: UITextField!
    
    @IBOutlet weak var showUserDataTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showUserDataTable.delegate = self
        self.showUserDataTable.dataSource = self
        
        self.showUserDataTable.register(UINib(nibName: "CustomCell", bundle: nil),
                                        forCellReuseIdentifier: "CustomCell_ID")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.searchUser.text = ""
        self.userDataArray.removeAll()
        self.showUserDataTable.reloadData()
        
    }
    
    @IBAction func saveUserBtnTapped(_ sender: UIButton) {
        
        if self.firstName.text != "" && self.lastName.text != "" {
            
            let userEnteredData = ["firstName":self.firstName.text!,
                                   "lastName":self.lastName.text!]
            
            CoreDataManager.save(entity: "UserData",
                                 userEnteredData: userEnteredData)
            
            self.myAlert(title: "Insertion Done",
                         message: "User Data has been inserted successfully",
                         actionTitle: "OK")
            
            self.firstName.text = ""
            self.lastName.text = ""
            
        }
        else {
            
            self.myAlert(title: "Empty Field",
                         message: "Field(s) cannot be left empty",
                         actionTitle: "OK")
            
        }
        
    }
    
    @IBAction func searchUserBtnTapped(_ sender: UIButton) {
        
        self.userDataArray.removeAll()
        
        self.userDataArray = CoreDataManager.singleSearch(searchString: self.searchUser.text!)
        
        self.showUserDataTable.reloadSections([0], with: .automatic)
        
    }
    
    func myAlert(title:String,message:String,actionTitle:String) {
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: actionTitle,
                                      style: UIAlertActionStyle.default,
                                      handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        self.view.endEditing(true)
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

