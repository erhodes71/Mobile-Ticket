//
//  InvestigateViewController.swift
//  SidebarMenu
//
//  Created by Eric Rhodes on 3/9/17.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import Foundation

class InvestigateViewController: UIViewController, UITextViewDelegate{
    
    
    
    @IBOutlet var reproduceIssue: UITextView!
    @IBOutlet var stepsTaken: UITextView!
    @IBOutlet var troubleShootingCustomer: UITextView!
    @IBOutlet var troubleShootingHelpDesk: UITextView!
    @IBOutlet var desiredOutcome: UITextView!
    
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
    
    var resolveIssue: String!
    var assignToSelf: String!
    var AssignToTeam: String!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Without setting the delegate you won't be able to track UITextView events
        reproduceIssue.delegate = self;
        stepsTaken.delegate = self;
        troubleShootingCustomer.delegate = self;
        troubleShootingHelpDesk.delegate = self;
        desiredOutcome.delegate = self;

    }
    
    func textViewDidChange(_ textView: UITextView) { //Handle the text changes here
        print(textView.text); //the textView parameter is the textView where text was changed
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "troubleShooting" {
            
            let toViewController = segue.destination
            if ((toViewController as? TicketReview ) != nil){
                //NSLog("This is the segue test");
                // toViewController.myData = "Test"
                var cont: TicketReview = toViewController as! TicketReview
                cont.service = service
                cont.category = category
                cont.subCategoryData = subCategoryData
                
                cont.ounetID = ounetID
                cont.titleOf = titleOf
                cont.descriptionOf = descriptionOf
                cont.building = building
                cont.roomNumber = roomNumber
                
                /*cont.resolveIssue = resolveIssue
                cont.assignToSelf = assignToSelf
                cont.AssignToTeam = AssignToTeam
                
                cont.email = email
                cont.phoneNumber = phoneNumber
                
                cont.reproduceIssue = reproduceIssue.text
                cont.listStepsTaken = stepsTaken.text
                cont.customerTroubleShooting = troubleShootingCustomer.text
                cont.helpDeskTroubleShooting = troubleShootingHelpDesk.text
                cont.desiredOutCome = desiredOutcome.text*/
                
                print("*******************************")
                print(cont.building)
                print("*******************************")
                
                
                
            }
            
        }
    }
    
    
    
}
