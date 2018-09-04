//
//  StatusViewController.swift
//  SidebarMenu
//
//  Created by Eric Rhodes on 3/8/17.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import Foundation


class StatusViewController: UIViewController{

    
    var service: String!
    var category: String!
    var subCategoryData: String!
    
    var ounetID: String!
    var titleOf: String!
    var descriptionOf: String!
    var building: String!
    var roomNumber: String!
    
    var email: String!
    var phoneNumber: String!
    
    var resolve: String = "False"
    var assignSelf: String = "False"
    var assignTeam: String = "False"

    @IBOutlet var test: ASIACheckmarkView!
    
    @IBAction func changeState(_ sender: ASIACheckmarkView) {
        sender.animate(checked:!sender.boolValue)
    }
    
    
    @IBAction func changeStateWithSpinning(_ sender: ASIACheckmarkView) {
        if !sender.isSpinning {
            sender.animate(checked:!sender.boolValue)
            sender.isSpinning = true
        }
        else {
            sender.isSpinning = false
        }
    }
    
    //Resolve Issue
    @IBAction func resolveIssue(_ sender: Any) {
        resolve = "True"
    }
    
    //Assign To self
    @IBAction func assignToSelf(_ sender: Any) {
        assignSelf = "True"
    }
    
    //Assign To Team
    @IBAction func assignToTeam(_ sender: Any) {
        assignTeam = "True"
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "status" {
            
            let toViewController = segue.destination
            if ((toViewController as? InvestigateViewController ) != nil){
                //NSLog("This is the segue test");
                // toViewController.myData = "Test"
                var cont: InvestigateViewController = toViewController as! InvestigateViewController
                cont.service = service
                cont.category = category
                cont.subCategoryData = subCategoryData
                
                cont.ounetID = ounetID
                cont.titleOf = titleOf
                cont.descriptionOf = descriptionOf
                cont.building = building
                cont.roomNumber = roomNumber
                
                /*
                cont.email = email
                cont.phoneNumber = phoneNumber
                
                cont.resolveIssue = resolve
                cont.assignToSelf = assignSelf
                cont.AssignToTeam = assignTeam*/
                
                print("*******************************")
                print(cont.building)
                print("*******************************")
                
                
            }
            
        }
    }


}
