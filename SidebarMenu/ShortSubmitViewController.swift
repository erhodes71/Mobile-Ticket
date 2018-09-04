//
//  ShortSubmitViewController.swift
//  SidebarMenu
//
//  Created by Eric Rhodes on 5/30/17.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import Foundation

class ShortSubmitViewController: UIViewController
{

    var service: String!
    var category: String!
    var subCategoryData: String!
    
    var ouNetID: String!
    var shortDescription: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Loading data in
        
        let defaults = UserDefaults.standard
        
        if let serv = defaults.string(forKey: "tempService")
        {
            service = serv
        }
        
        if let catt = defaults.string(forKey: "tempCategory")
        {
            category = catt
        }
        
        if let subb = defaults.string(forKey: "tempSub")
        {
            subCategoryData = subb
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /*
        //Change to the right name of segue*
        if segue.identifier == "changMind" {
            
            let toViewController = segue.destination
            //Change to proper class type
            if ((toViewController as? CustomerInfo ) != nil){
                //Set the appropriate variables to eachother
                var cont: CustomerInfo = toViewController as! CustomerInfo
                //cont.name = name
                //cont.service = service
                //cont.category = category
                //cont.subCategoryData = subCategoryData
                
                //cont.OUNetID.text = ouNetID
                
                
                
            }
            
        }
        
        if segue.identifier == "recategory" {
            
            let toViewController = segue.destination
            if ((toViewController as? CategoryViewController ) != nil){
                NSLog("This is the segue test");
                // toViewController.myData = "Test"
                let cont: CategoryViewController = toViewController as! CategoryViewController
                //cont.service = service
                
                
                
                
            }
            
        }
 */
    }
    
    @IBAction func MakeMoreChanges(_ sender: Any) {
        //performSegue(withIdentifier: "changeMind", sender: AnyObject?.self)

    }
    
    
    
    
   
}
