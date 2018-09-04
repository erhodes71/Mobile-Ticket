//
//  CoverageViewController.swift
//  Quick Ticket
//
//  Created by Eric Rhodes on 4/4/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import Foundation

class CoverageViewController: UIViewController
{
    
    
    @IBOutlet var universityOwnedButton: UIButton!
    @IBOutlet var personallyOwnedButton: UIButton!
    
    @IBOutlet var appleCareButton: UIButton!
    @IBOutlet var dellWarrantyButton: UIButton!
    @IBOutlet var otherWarrantyButton: UIButton!
    @IBOutlet var noWarrantyButton: UIButton!
    
    @IBOutlet var furtherDiagnosisNeededButton: UIButton!
    @IBOutlet var repairReplacmentButton: UIButton!
    @IBOutlet var softwareInstallButton: UIButton!
    @IBOutlet var virusMalwareButton: UIButton!
    @IBOutlet var networkIssueButton: UIButton!
    @IBOutlet var willNotBootButton: UIButton!
    
    //String to hold the thing selected
    var deviceOwnership: String!
    var warranty: String!
    var checkInCategory: String!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    //Updates the data for different selections
    func updateDate(key: String, value: String)
    {
        //Add save data here
        let defaults = UserDefaults.standard
        
        //data tempararaly saved
        defaults.set(value, forKey: key)
        
        
    }
    
    
    
    //Button Presses
    //********************
    
    //University Owned Button Pressed
    @IBAction func universityOwnedButtonPressed(_ sender: Any) {
        deviceOwnership = "University Owned"
        universityOwnedButton.isSelected = true
        personallyOwnedButton.isSelected = false
        updateDate(key: "tempDeviceOwnership", value: deviceOwnership)
    }
    @IBAction func personallyOwnedButtonPressed(_ sender: Any) {
        deviceOwnership = "Personally Owned"
        universityOwnedButton.isSelected = false
        personallyOwnedButton.isSelected = true
        updateDate(key: "tempDeviceOwnership", value: deviceOwnership)
    }
    
    
    //Warranty
    @IBAction func appleCareButtonPressed(_ sender: Any) {
        warranty = "Apple/Apple Care"
        appleCareButton.isSelected = true
        dellWarrantyButton.isSelected = false
        otherWarrantyButton.isSelected = false
        noWarrantyButton.isSelected = false
        updateDate(key: "tempWarranty", value: warranty)
    }
    @IBAction func dellWarrantyButtonPressed(_ sender: Any) {
        warranty = "Dell Warranty"
        appleCareButton.isSelected = false
        dellWarrantyButton.isSelected = true
        otherWarrantyButton.isSelected = false
        noWarrantyButton.isSelected = false
        updateDate(key: "tempWarranty", value: warranty)

    }
    @IBAction func otherWarrantyButtonPressed(_ sender: Any) {
        warranty = "Other Warranty"
        appleCareButton.isSelected = false
        dellWarrantyButton.isSelected = false
        otherWarrantyButton.isSelected = true
        noWarrantyButton.isSelected = false
        updateDate(key: "tempWarranty", value: warranty)

    }
    @IBAction func noWarrantyButtonPressed(_ sender: Any) {
        warranty = "No Warranty"
        appleCareButton.isSelected = false
        dellWarrantyButton.isSelected = false
        otherWarrantyButton.isSelected = false
        noWarrantyButton.isSelected = true
        updateDate(key: "tempWarranty", value: warranty)


    }
    
    //Check in Category
    @IBAction func furtherDiagnosisNeededButtonPressed(_ sender: Any) {
        checkInCategory = "Further Diagnosis Needed"
        furtherDiagnosisNeededButton.isSelected = true
        repairReplacmentButton.isSelected = false
        softwareInstallButton.isSelected = false
        virusMalwareButton.isSelected = false
        networkIssueButton.isSelected = false
        willNotBootButton.isSelected = false
        updateDate(key: "tempCheckInCategory", value: checkInCategory)

    }
    @IBAction func repairReplacmentButtonPressed(_ sender: Any) {
        checkInCategory = "Repair/Replacment"
        furtherDiagnosisNeededButton.isSelected = false
        repairReplacmentButton.isSelected = true
        softwareInstallButton.isSelected = false
        virusMalwareButton.isSelected = false
        networkIssueButton.isSelected = false
        willNotBootButton.isSelected = false
        updateDate(key: "tempCheckInCategory", value: checkInCategory)

    }
    @IBAction func softwareInstallButtonPressed(_ sender: Any) {
        checkInCategory = "Software Install"
        furtherDiagnosisNeededButton.isSelected = false
        repairReplacmentButton.isSelected = false
        softwareInstallButton.isSelected = true
        virusMalwareButton.isSelected = false
        networkIssueButton.isSelected = false
        willNotBootButton.isSelected = false
        updateDate(key: "tempCheckInCategory", value: checkInCategory)

    }
    @IBAction func virusMalwareButtonPressed(_ sender: Any) {
        checkInCategory = "Virus/Malware"
        furtherDiagnosisNeededButton.isSelected = false
        repairReplacmentButton.isSelected = false
        softwareInstallButton.isSelected = false
        virusMalwareButton.isSelected = true
        networkIssueButton.isSelected = false
        willNotBootButton.isSelected = false
        updateDate(key: "tempCheckInCategory", value: checkInCategory)

    }
    @IBAction func networkIssueButtonPressed(_ sender: Any) {
        checkInCategory = "Network Issue"
        furtherDiagnosisNeededButton.isSelected = false
        repairReplacmentButton.isSelected = false
        softwareInstallButton.isSelected = false
        virusMalwareButton.isSelected = false
        networkIssueButton.isSelected = true
        willNotBootButton.isSelected = false
        updateDate(key: "tempCheckInCategory", value: checkInCategory)

    }
    @IBAction func willNotBottButtonPressed(_ sender: Any) {
        checkInCategory = "Will Not Boot"
        furtherDiagnosisNeededButton.isSelected = false
        repairReplacmentButton.isSelected = false
        softwareInstallButton.isSelected = false
        virusMalwareButton.isSelected = false
        networkIssueButton.isSelected = false
        willNotBootButton.isSelected = true
        updateDate(key: "tempCheckInCategory", value: checkInCategory)

    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}
