//
//  MachineInformationViewController.swift
//  Quick Ticket
//
//  Created by Eric Rhodes on 4/5/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import Foundation

class MachineInformationViewController: UIViewController
{
    //Device Type
    @IBOutlet var notebookButton: UIButton!
    @IBOutlet var desktopButton: UIButton!
    @IBOutlet var tabletButton: UIButton!
    
    //Brand
    @IBOutlet var dellButton: UIButton!
    @IBOutlet var appleButton: UIButton!
    @IBOutlet var hpButton: UIButton!
    @IBOutlet var lenovoButton: UIButton!
    @IBOutlet var microsoftButton: UIButton!
    @IBOutlet var otherButton: UIButton!
    
    @IBOutlet var pcButton: UIButton!
    @IBOutlet var appleButton_2: UIButton!
    
    @IBOutlet var serialNumberTextField: UITextField!
    @IBOutlet var modelTextField: UITextField!
    
    //String to hold the thing selected
    var deviceType: String!
    var brand: String!
    var make: String!
    
    var serialNumber: String!
    var model: String!
    
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
    
    //Device Type action listeners
    @IBAction func Notebook(_ sender: Any) {
        deviceType = "Notebook"
        notebookButton.isSelected = true
        desktopButton.isSelected = false
        tabletButton.isSelected = false
        updateData(key: "tempDeviceType", value: deviceType)
    }
    
    @IBAction func Desktop(_ sender: Any) {
        deviceType = "Desktop"
        notebookButton.isSelected = false
        desktopButton.isSelected = true
        tabletButton.isSelected = false
        updateData(key: "tempDeviceType", value: deviceType)
    }
    
    @IBAction func Tablet(_ sender: Any) {
        deviceType = "Tablet"
        notebookButton.isSelected = false
        desktopButton.isSelected = false
        tabletButton.isSelected = true
        updateData(key: "tempDeviceType", value: deviceType)
    }
    
    //Brand
    @IBAction func Dell(_ sender: Any) {
        brand = "Dell"
        dellButton.isSelected = true
        appleButton.isSelected = false
        hpButton.isSelected = false
        lenovoButton.isSelected = false
        microsoftButton.isSelected = false
        otherButton.isSelected = false
        updateData(key: "tempBrand", value: brand)
    }
    
    @IBAction func Apple(_ sender: Any) {
        brand = "Apple"
        dellButton.isSelected = false
        appleButton.isSelected = true
        hpButton.isSelected = false
        lenovoButton.isSelected = false
        microsoftButton.isSelected = false
        otherButton.isSelected = false
        updateData(key: "tempBrand", value: brand)
    }
    
    @IBAction func HP(_ sender: Any) {
        brand = "HP"
        dellButton.isSelected = false
        appleButton.isSelected = false
        hpButton.isSelected = true
        lenovoButton.isSelected = false
        microsoftButton.isSelected = false
        otherButton.isSelected = false
        updateData(key: "tempBrand", value: brand)
    }
    
    @IBAction func Lenovo(_ sender: Any) {
        brand = "Lenovo"
        dellButton.isSelected = false
        appleButton.isSelected = false
        hpButton.isSelected = false
        lenovoButton.isSelected = true
        microsoftButton.isSelected = false
        otherButton.isSelected = false
        updateData(key: "tempBrand", value: brand)
    }
    
    @IBAction func MicrosoftSurface(_ sender: Any) {
        brand = "Microsoft Surface"
        dellButton.isSelected = false
        appleButton.isSelected = false
        hpButton.isSelected = false
        lenovoButton.isSelected = false
        microsoftButton.isSelected = true
        otherButton.isSelected = false
        updateData(key: "tempBrand", value: brand)
    }
    
    @IBAction func Other(_ sender: Any) {
        brand = "Other"
        dellButton.isSelected = false
        appleButton.isSelected = false
        hpButton.isSelected = false
        lenovoButton.isSelected = false
        microsoftButton.isSelected = false
        otherButton.isSelected = true
        updateData(key: "tempBrand", value: brand)
    }
    
    //Make
    @IBAction func PC(_ sender: Any) {
        make = "PC"
        pcButton.isSelected = true
        appleButton_2.isSelected = false
        updateData(key: "tempMake", value: make)
    }
    
    @IBAction func Apple_2(_ sender: Any) {
        make = "Apple"
        pcButton.isSelected = false
        appleButton_2.isSelected = true
        updateData(key: "tempMake", value: make)
    }
    
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        updateData(key: "tempSerialNumber", value: serialNumberTextField.text!)
        updateData(key: "tempModel", value: modelTextField.text!)
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
