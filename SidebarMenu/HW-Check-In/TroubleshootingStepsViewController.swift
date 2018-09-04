//
//  TroubleshootingStepsViewController.swift
//  Quick Ticket
//
//  Created by Eric Rhodes on 4/12/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import Foundation

class TroubleshootingStepsViewController: UIViewController{
    
    @IBOutlet var yesButton: UIButton!
    @IBOutlet var noButton: UIButton!
    
    @IBOutlet var stepsTakenTextView: UITextView!
    @IBOutlet var recordIssueDetailsTextView: UITextView!
    
    var issueVerified: String!
    var stepsTaken: String!
    var recordIssueDetails: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    //Updates the data for different selections
    func updateData(key: String, value: String)
    {
        //Add save data here
        let defaults = UserDefaults.standard
        
        //data tempararaly saved
        defaults.set(value, forKey: key)
        
    }
    
    
    @IBAction func yesButtonPressed(_ sender: Any) {
        issueVerified = "True"
    }
    
    @IBAction func noButtonPressed(_ sender: Any) {
        issueVerified = "False"
    }
    
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        stepsTaken = stepsTakenTextView.text
        recordIssueDetails = recordIssueDetailsTextView.text
        updateData(key: "tempIssueVerified", value: issueVerified)
        updateData(key: "tempStepsTaken", value: stepsTaken)
        updateData(key: "tempRecordIssueDetails", value: recordIssueDetails)
    }
    
    
    
    
    
}
