//
//  DataBackupViewController.swift
//  SidebarMenu
//
//  Created by Eric Rhodes on 4/27/17.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import Foundation
import UIKit


class DataBackupTableViewCell: UITableViewCell
{
    
    @IBOutlet var lable: UILabel!
    
    
}


class DataBackupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var tableView: UITableView!
    
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"
    
    
    let list: [String] = ["Awaiting Backup", "Backup Completed", "Not Required"]

    
    
    //User Data
    var name: String!
    var OUNetID: String!
    var phone: String!
    var email: String!
    
    //Computer Type
    var computerType: String!
    
    //Computer Make
    var computerMake: String!
    
    //Data Backup
    var dataBackup: String!
    
    //Delivery Information
    var deliveryInformation: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register the table view cell class and its reuse id
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
    }
       
    
    func nextView()
    {
        //Add save data here
        let defaults = UserDefaults.standard
        
        //Servie data tempararaly saved
        defaults.set(dataBackup, forKey: "tempDataBackup")
        
        //performSegue(withIdentifier: "dataBackup", sender: AnyObject?.self)
        performSegue(withIdentifier: "dataBackup", sender: AnyObject?.self)
    }
    
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
        
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:DataBackupTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "LableCell") as UITableViewCell! as! DataBackupTableViewCell
        
        // set the text from the data model
        cell.lable?.text = self.list[indexPath.row]
        
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        dataBackup = list[indexPath.row];
        print("Test____")
        print(dataBackup)
       
        nextView()
        
    }
    
    
    
}
