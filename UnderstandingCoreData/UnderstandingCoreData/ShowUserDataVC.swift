//
//  ShowUserDataVC.swift
//  UnderstandingCoreData
//
//  Created by appinventiv on 19/09/17.
//  Copyright © 2017 yogesh singh negi. All rights reserved.
//

import UIKit

class ShowUserDataVC: UIViewController {

    var userDataArray:[UserData] = []
    
    @IBOutlet weak var showUserDataTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.showUserDataTable.delegate = self
        self.showUserDataTable.dataSource = self
        
        let cell = UINib(nibName: "CustomCell", bundle: nil)
        self.showUserDataTable.register(cell, forCellReuseIdentifier: "CustomCell_ID")
        
        self.fetchData()
        
    }
    
    @IBAction func backBtnTapped(_ sender: UIBarButtonItem) {
        
        presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    func fetchData() {
        
        var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            userDataArray = try context.fetch(UserData.fetchRequest())
        } catch {
            print(error)
        }
        
    }
    
    
}

extension ShowUserDataVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell_ID") as? CustomCell else { fatalError("Cell Not initailised") }
        
        let fullName = self.userDataArray[indexPath.row]
        
        cell.showData.text = fullName.firstName! + " " + fullName.lastName!
        
        return cell
        
    }
    
    
}
