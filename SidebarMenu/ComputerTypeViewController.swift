//
//  ComputerTypeViewController.swift
//  SidebarMenu
//
//  Created by Eric Rhodes on 4/27/17.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import Foundation
import UIKit


class ComputerTypeViewControllerCell: UITableViewCell
{
    
    @IBOutlet var lable: UILabel!
    
    
}



class ComputerTypeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    
    @IBOutlet var tableView: UITableView!
    
    let list: [String] = ["Desktop", "Laptop", "Tablet", "Other"]
    
    //User Data
    var name: String!
    var OUNetID: String!
    var phone: String!
    var email: String!
    
    
    
    //Computer Type
    var computerType: String!
    
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //Change to the right name of segue*
        if segue.identifier == "computerType" {
            
            let toViewController = segue.destination
            //Change to proper class type
            if ((toViewController as? ComputerMakeViewController ) != nil){
                //Set the appropriate variables to eachother
                var cont: ComputerMakeViewController = toViewController as! ComputerMakeViewController
               
                
                // Register the table view cell class and its reuse id
                self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
                
                
                tableView.delegate = self
                tableView.dataSource = self
                
            }
            
        }
    }
    
    //Move to next controller
    func nextView()
    {
        //Add save data here
        let defaults = UserDefaults.standard
        
        //Servie data tempararaly saved
        defaults.set(computerType, forKey: "tempComputerType")
        
        
        performSegue(withIdentifier: "computerType", sender: AnyObject?.self)
        
    }
    
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
        
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:ComputerTypeViewControllerCell = self.tableView.dequeueReusableCell(withIdentifier: "LableCell") as UITableViewCell! as! ComputerTypeViewControllerCell
        
        // set the text from the data model
        cell.lable?.text = self.list[indexPath.row]
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        computerType = list[indexPath.row];
        nextView()
        
    }



}
