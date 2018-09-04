//
//  FinishViewController.swift
//  Quick Ticket
//
//  Created by Eric Rhodes on 7/2/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import Foundation
import Foundation
import Alamofire


class FinishViewController: UIViewController{
    
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UITextView!
    @IBOutlet var stepsTakenLabel: UITextView!
    @IBOutlet var recordIssueDetailsLabel: UITextView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Loads the information from the forms
        let defaults = UserDefaults.standard
        
        if let grab = defaults.string(forKey: "tempShortDescription")
        {
            titleLabel.text = grab
        }
        if let grab = defaults.string(forKey: "tempDescription")
        {
            descriptionLabel.text = grab
        }
        if let grab = defaults.string(forKey: "tempStepsTaken")
        {
            stepsTakenLabel.text = grab
        }
        if let grab = defaults.string(forKey: "tempRecordIssueDetails")
        {
            recordIssueDetailsLabel.text = grab
        }
        
    }

}
