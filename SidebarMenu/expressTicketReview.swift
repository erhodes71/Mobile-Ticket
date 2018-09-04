//
//  expressTicketReview.swift
//  SidebarMenu
//
//  Created by Eric Rhodes on 5/4/17.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import Foundation
import Alamofire


class expressTicketReview: UIViewController{

    
    //Tech Data
    var name: String!
    var OUNetID: String!
    var phone: String!
    var email: String!
    
    
    var userName: String!
    var userPhoneText: String!
    
    
    //Computer Type
    var computerType: String!
    
    //Computer Make
    var computerMake: String!
    
    //Data Backup
    var dataBackup: String!
    
    //Serial number
    var serialNumber: String!
    
    //Pickup Location
    var pickupLocation: String!
    //Pickup Room
    var pickupRoom: String!
    //Delivery Location
    var deliveryLocationText: String!
    //Delivery Room
    var deliveryRoom: String!
    
    var descriptionText: String!
    
    //Indicator
    @IBOutlet var indicator: UIActivityIndicatorView!
    
    
    //UI Lables
    @IBOutlet var techNameLable: UILabel!
    @IBOutlet var techPhone: UILabel!
    @IBOutlet var techEmail: UILabel!
    
    @IBOutlet var userOUNetID: UILabel!
    @IBOutlet var userPhone: UILabel!
    
    @IBOutlet var affectedComputerType: UILabel!
    @IBOutlet var affectedComputerMake: UILabel!
    @IBOutlet var serialNumberLable: UILabel!
    @IBOutlet var backupOptionLable: UILabel!
    @IBOutlet var pickupLocationLable: UILabel!
    @IBOutlet var deliveryLocationLable: UILabel!
    @IBOutlet var descriptionLable: UITextView!
    
    
    @IBOutlet var returnMessage: UILabel!
    
    @IBOutlet var submitTicketButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.indicator.hidesWhenStopped = true
        
        let defaults = UserDefaults.standard
     
        OUNetID = defaults.string(forKey: "username")
        
        //techNameLable.text = "Eric Rhodes"
        //techPhone.text = "7179031909"
        //techEmail.text = "erhodes71@gmail.com"
        
        techNameLable.text = defaults.string(forKey: "name")
        //techPhone.text = "" //defaults.string(forKey: "phone")
        //techEmail.text = "" //defaults.string(forKey: "email")
        
        userOUNetID.text = defaults.string(forKey: "tempOUNetID")
        userPhone.text = defaults.string(forKey: "tempPhoneNumber")
        
        affectedComputerType.text = defaults.string(forKey: "tempComputerType")
        affectedComputerMake.text = defaults.string(forKey: "tempComputerMake")
        serialNumberLable.text = defaults.string(forKey: "tempSerialNumber")
        
        backupOptionLable.text = defaults.string(forKey: "tempDataBackup")
        
        pickupLocationLable.text = defaults.string(forKey: "tempPickupLocation")
        deliveryLocationLable.text = defaults.string(forKey: "tempDeliveryLocation")
        pickupRoom = defaults.string(forKey: "tempPickupRoom")
        deliveryRoom = defaults.string(forKey: "tempDeliveryRoom")
        
        descriptionLable.text = defaults.string(forKey: "tempDescription")
        
        //--//--//--//
        
        
        userName = userOUNetID.text
        userPhoneText = userPhone.text
        
        computerType = affectedComputerType.text
        computerMake = affectedComputerMake.text
        serialNumber = serialNumberLable.text
        
        dataBackup = backupOptionLable.text
        
        serialNumber = serialNumberLable.text
        
        pickupLocation = pickupLocationLable.text
        deliveryLocationText = deliveryLocationLable.text
        
        
        descriptionText = descriptionLable.text
        
        email = ""
        phone = ""
        
    
    }
    
    @IBAction func submitTicket(_ sender: Any) {
        printResults2();
        indicator.startAnimating()

    }
    func printResults2()
    {
        
        /*
        var userName = ""
        let defaults = UserDefaults.standard
        
        if let name = defaults.string(forKey: "username")
        {
            userName = name
            // Will output "theGreatestName"
        }
         */
        var stringNEW9 = "http://servicesapps.ou.edu/quick-ticket/Sources/QuickTicketBackend.php?assignedTeam=services&user=rhod0974&short=test&email=email&phone=7179031909&long=test&service=Instructional%20Technology&category=Classroom%20Response%20System&sub=Not%20Listed&userIn=rhod0974"
        
        //New
        //var stringNEW10 = "http://servicesapps.ou.edu/quick-ticket/Sources/QuickTicketExpress.php?assignedTeam=services"+"&user="+userName+"&tech="+OUNetID+"&e="+email+"&p="+phone+"&up="+userPhoneText+"&ct="+computerType+"&cm="+computerMake+"&sn="+serialNumber+"&bu="+dataBackup+"&pl="+pickupLocation+"&pr="+pickupRoom+"&dl="+deliveryLocationText+"&dr="+deliveryRoom+"&d="+descriptionText
        
        
        //"http://servicesapps.ou.edu/quick-ticket/Sources/QuickTicketExpress.php?assignedTeam=services&user=%@&tech=%@&e=%@&p=%@&up=%@&ct=%@&cm=%@&sn=%@&bu=%@&pl=%@&pr=%@&dl=%@&dr=%@&d=%@"
        
        
        var stringNEW11 = String(format: "http://servicesapps.ou.edu/quick-ticket/Sources/QuickTicketExpress.php?assignedTeam=services&user=%@&tech=%@&e=%@&p=%@&up=%@&ct=%@&cm=%@&sn=%@&bu=%@&pl=%@&pr=%@&dl=%@&dr=%@&d=%@", userName, OUNetID, email, phone, userPhoneText, computerType, computerMake, serialNumber, dataBackup ,pickupLocation, pickupRoom, deliveryLocationText, deliveryRoom, descriptionText)
        
        
        let newLink = stringNEW11.replacingOccurrences(of: " ", with: "%20")
        print(newLink)
        
 
        
        
        var incidentNumber = ""
        //stringNEW2
        Alamofire.request(newLink, method: .get, encoding: JSONEncoding.default)
            .responseString { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                
                if let json = response.result.value {
                    print("JSON: \(json)")
                    
                    
                    if let data = json.data(using: (String.Encoding.utf8)) {
                        let json = JSON(data: data)
                        print("Test")
                        print(json)
                        var v = json.dictionary
                        
                        var theMainValue = ""
                        for (key, value) in v! {
                            print("\(key) -> \(value)")
                            if(key == "busObPublicId")
                            {
                                theMainValue = value.string!
                            }
                        }
                        
                        //let q = v?.first?.key //This returns the key!
                        //let q = v?.first?.value
                        //let q = v?.index(forKey: "errorCode")
                        
                        let yy = v?.index(after: (v?.index(forKey: "busObPublicId"))!)
                        let q = v?.index(forKey: "busObPublicId")
                        let b = v?.popFirst()
                        let c = v?.popFirst()
                        let d = v?.popFirst()
                        let e = v?.popFirst()
                        //let t = q?.value
                        print(e)
                        //let s = e!.value.stringValue
                        let s  = theMainValue
                        print(s)//FINALLY WORKS
                        self.returnMessage.text = s
                        print("Test")
                        print("This will test extraction:")
                        print(theMainValue)
                        print("**************************")
                        
                        print("THIS IS S::::: ")
                        print(s)
                        
                        if(theMainValue == "")
                        {
                            self.returnMessage.text = "Error Processing Request"
                        }
                        
                        
                        self.indicator.stopAnimating()
                        self.submitTicketButton.isHidden = true;
                    }
                    
                    
                    
                }
               
                
                
        }
        
        
    }



}
