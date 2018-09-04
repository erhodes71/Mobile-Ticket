//
//  OSUserInformationViewController.swift
//  Quick Ticket
//
//  Created by Eric Rhodes on 4/11/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import Foundation

class OSUserInformationViewController: UIViewController{
    
    @IBOutlet var windows7Button: UIButton!
    @IBOutlet var windows8Button: UIButton!
    @IBOutlet var windows10Button: UIButton!
    @IBOutlet var macOSXButton: UIButton!
    @IBOutlet var otherButton: UIButton!
    
    @IBOutlet var versionTextField: UITextField!
    @IBOutlet var localTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    //String to hold the thing selected
    var OS: String!
    var version: String!
    var local: String!
    var password: String!
    
    
    
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
    
    @IBAction func Windows7ButtonPressed(_ sender: Any) {
        OS = "Windows 7"
        windows7Button.isSelected = true
        windows8Button.isSelected = false
        windows10Button.isSelected = false
        macOSXButton.isSelected = false
        otherButton.isSelected = false
        updateData(key: "tempOS", value: OS)
    }
    
    @IBAction func Windows8ButtonPressed(_ sender: Any) {
        OS = "Windows 8"
        windows7Button.isSelected = false
        windows8Button.isSelected = true
        windows10Button.isSelected = false
        macOSXButton.isSelected = false
        otherButton.isSelected = false
        updateData(key: "tempOS", value: OS)
    }
    
    @IBAction func Windows10ButtonPressed(_ sender: Any) {
        OS = "Windows 10"
        windows7Button.isSelected = false
        windows8Button.isSelected = false
        windows10Button.isSelected = true
        macOSXButton.isSelected = false
        otherButton.isSelected = false
        updateData(key: "tempOS", value: OS)
    }
    
    @IBAction func MacOSXButtonPressed(_ sender: Any) {
        OS = "Windows Mac OSX"
        windows7Button.isSelected = false
        windows8Button.isSelected = false
        windows10Button.isSelected = false
        macOSXButton.isSelected = true
        otherButton.isSelected = false
        updateData(key: "tempOS", value: OS)
    }
    
    @IBAction func OtherButtonPressed(_ sender: Any) {
        OS = "Other"
        windows7Button.isSelected = false
        windows8Button.isSelected = false
        windows10Button.isSelected = false
        macOSXButton.isSelected = false
        otherButton.isSelected = true
        updateData(key: "tempOS", value: OS)
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        updateData(key: "tempVersion", value: versionTextField.text!)
        updateData(key: "tempLocal", value: localTextField.text!)
        updateData(key: "tempPassword", value: passwordTextField.text!)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
