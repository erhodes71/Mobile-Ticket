//
//  ComputerMakeViewController.swift
//  SidebarMenu
//
//  Created by Eric Rhodes on 4/27/17.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import Foundation
import UIKit

class ComputerMakeTableViewCell: UITableViewCell
{
    
    @IBOutlet var lable: UILabel!
    
    
}


class ComputerMakeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var tableView: UITableView!
    
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"
    
    
    let list: [String] = ["Non case", "Service Documentation and Assistance", "Service Requests", "Technical Support"]

    
    //User Data
    var name: String!
    var OUNetID: String!
    var phone: String!
    var email: String!
    
    //Computer Type
    var computerType: String!
    
    //Computer Make
    var computerMake: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register the table view cell class and its reuse id
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        ///print("Test____")
        //print(name)
        //print(OUNetID)
        //print(phone)
        //print(email)
        //print(computerType)
        //print(computerMake)
        //print(dataBackup)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //Change to the right name of segue*
        if segue.identifier == "computerMake" {
            
            let toViewController = segue.destination
            //Change to proper class type
            if ((toViewController as? DataBackupViewController ) != nil){
                //Set the appropriate variables to eachother
                var cont: DataBackupViewController = toViewController as! DataBackupViewController
                //cont.name = name
                //cont.OUNetID = OUNetID
                //cont.phone = phone
                //cont.email = email
                
                //cont.computerType = computerType
                
                //cont.computerMake = computerMake
                
            }
            
        }
    }
    
    
    func nextView()
    {
        //Add save data here
        let defaults = UserDefaults.standard
        
        //Servie data tempararaly saved
        defaults.set(computerMake, forKey: "tempComputerMake")
        
        performSegue(withIdentifier: "computerMake", sender: AnyObject?.self)
        
    }
    
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
        
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:ComputerMakeTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "LableCell") as UITableViewCell! as! ComputerMakeTableViewCell
        
        // set the text from the data model
        cell.lable?.text = self.list[indexPath.row]
        
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        computerMake = list[indexPath.row];
        
        nextView()
        
    }

}
