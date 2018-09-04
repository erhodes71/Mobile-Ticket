//
//  FinalizeViewController.swift
//  Quick Ticket
//
//  Created by Eric Rhodes on 7/2/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import Foundation
import Foundation
import Alamofire


class FinalizeViewController: UIViewController{
    
    
    @IBOutlet var serviceLabel: UILabel!
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var subCategoryLabel: UILabel!
    @IBOutlet var ounetidLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var phoneLabel: UILabel!
    @IBOutlet var deviceOwnershipLabel: UILabel!
    @IBOutlet var warrentyLabel: UILabel!
    @IBOutlet var checkInCategoryLabel: UILabel!
    @IBOutlet var deviceTypeLabel: UILabel!
    @IBOutlet var brandLabel: UILabel!
    @IBOutlet var makeLabel: UILabel!
    @IBOutlet var serialNumberLabel: UILabel!
    @IBOutlet var modelLabel: UILabel!
    @IBOutlet var osLabel: UILabel!
    @IBOutlet var versionLabel: UILabel!
    @IBOutlet var loginLabel: UILabel!
    @IBOutlet var passwordLabel: UILabel!
    @IBOutlet var issueVerifiedLabel: UILabel!
    @IBOutlet var checkInLocationLabel: UILabel!
    @IBOutlet var checkInShelfLabel: UILabel!
    @IBOutlet var currentLocationLabel: UILabel!
    @IBOutlet var currentShelfLabel: UILabel!
    @IBOutlet var transferToLocationLabel: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Loads the information from the forms
        let defaults = UserDefaults.standard
        
        if let grab = defaults.string(forKey: "tempService")
        {
            serviceLabel.text = grab
        }
        if let grab = defaults.string(forKey: "tempCategory")
        {
            categoryLabel.text = grab
        }
        if let grab = defaults.string(forKey: "tempSub")
        {
            subCategoryLabel.text = grab
        }
        if let grab = defaults.string(forKey: "tempOUNetID")
        {
            ounetidLabel.text = grab
        }
        if let grab = defaults.string(forKey: "tempPhoneNumber")
        {
            phoneLabel.text = grab
        }
        if let grab = defaults.string(forKey: "tempEmail")
        {
            emailLabel.text = grab
        }
        if let grab = defaults.string(forKey: "tempDeviceOwnership")
        {
            deviceOwnershipLabel.text = grab
        }
        if let grab = defaults.string(forKey: "tempWarranty")
        {
            warrentyLabel.text = grab
        }
        if let grab = defaults.string(forKey: "tempCheckInCategory")
        {
            checkInCategoryLabel.text = grab
        }
        if let grab = defaults.string(forKey: "tempDeviceType")
        {
            deviceTypeLabel.text = grab
        }
        if let grab = defaults.string(forKey: "tempBrand")
        {
            brandLabel.text = grab
        }
        if let grab = defaults.string(forKey: "tempMake")
        {
            makeLabel.text = grab
        }
        if let grab = defaults.string(forKey: "tempSerialNumber")
        {
            serialNumberLabel.text = grab
        }
        if let grab = defaults.string(forKey: "tempModel")
        {
            modelLabel.text = grab
        }
        if let grab = defaults.string(forKey: "tempOS")
        {
            osLabel.text = grab
        }
        if let grab = defaults.string(forKey: "tempVersion")
        {
            versionLabel.text = grab
        }
        if let grab = defaults.string(forKey: "tempLocal")
        {
            loginLabel.text = grab
        }
        if let grab = defaults.string(forKey: "tempPassword")
        {
            passwordLabel.text = grab
        }
        if let grab = defaults.string(forKey: "tempCheckInLocation")
        {
            checkInLocationLabel.text = grab
        }
        if let grab = defaults.string(forKey: "tempCheckInShelf")
        {
            checkInShelfLabel.text = grab
        }
        if let grab = defaults.string(forKey: "tempCurrentLocation")
        {
            currentLocationLabel.text = grab
        }
        if let grab = defaults.string(forKey: "tempCurrentShelf")
        {
            currentShelfLabel.text = grab
        }
        if let grab = defaults.string(forKey: "tempTransferLocation")
        {
            transferToLocationLabel.text = grab
        }
    }
    
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        
        
        
        
        
    }
    
    
}
