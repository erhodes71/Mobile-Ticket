//
//  SubmitTicketLaterViewController.swift
//  SidebarMenu
//
//  Created by Eric Rhodes on 6/19/17.
//  Copyright © 2017 AppCoda. All rights reserved.
//


//https://cherwellsupport.com/CherwellAPI/Swagger/ui/index
//

import Foundation
import Alamofire


class SubmitTicketLaterViewController: UIViewController{
    
    //*******ID/TOKEN for Status*****//
    //5eb3234ae1344c64a19819eda437f18d
    
    
    
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
    
    @IBOutlet var submitTicketText: UILabel!
    
    @IBOutlet var submitButton: UIButton!
    
    @IBOutlet var incidentID: UILabel!
    
    @IBOutlet var indicator: UIActivityIndicatorView!
    
    @IBOutlet weak var serviceButton: UIButton!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var subCategoryButton: UIButton!
    @IBOutlet weak var customerInformationButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print("*******************************")
        //print(building)
        print("*******************************")
        
        self.indicator.hidesWhenStopped = true
        
        let defaults = UserDefaults.standard
        
        
        if let serv = defaults.string(forKey: "tempService")
        {
            service = serv
            print("Service: "+service)
            service = service.replacingOccurrences(of: "&", with: "%26")
        }
        
        if let catt = defaults.string(forKey: "tempCategory")
        {
            category = catt
            print("Category: "+category)
            category = category.replacingOccurrences(of: "&", with: "%26")
        }
        
        if let subCatt = defaults.string(forKey: "tempSub")
        {
            subCategoryData = subCatt
            print("SubCategory: "+subCategoryData)
            subCategoryData = subCategoryData.replacingOccurrences(of: "&", with: "%26")
        }
        
        //-----//-----//-----//-----//-----
        
        if let OUNetID = defaults.string(forKey: "tempOUNetID")
        {
            ounetID = OUNetID
            print("OUNetID: "+ounetID)

        }
        
        if let phoneNumber2 = defaults.string(forKey: "tempPhoneNumber")
        {
            phoneNumber = phoneNumber2
            print("Phone Number: "+phoneNumber2)

        }
        
        if let emailNumber = defaults.string(forKey: "tempEmail")
        {
            email = emailNumber
            print("Email: "+email)

        }
        
        if let shortDescription = defaults.string(forKey: "tempShortDescription")
        {
            titleOf = shortDescription
            print("Title: "+titleOf)
            titleOf = titleOf.replacingOccurrences(of: "&", with: "%26")


        }
        
        if let descript = defaults.string(forKey: "tempDescription")
        {
            descriptionOf = descript
            print("Description: "+descriptionOf)
            descriptionOf = descriptionOf.replacingOccurrences(of: "&", with: "%26")


        }
        
        if let build = defaults.string(forKey: "tempBuilding")
        {
            building = build
            print("Building: "+building)

        }
        
        if let roomNum = defaults.string(forKey: "tempRoomNumber")
        {
            roomNumber = roomNum
            print("Room Number: "+roomNumber)

        }
        
        
        
        var serviceCUT = ""
        if service.characters.count > 9{
            //This works for parsing data
            let servIndex = service.index(service.startIndex, offsetBy: 9)
            serviceCUT = service.substring(to: servIndex)
            print("Test")
            print(serviceCUT)
        }else{
            serviceCUT = service
        }
        
        var catCUT = ""
        if category.characters.count > 9{
            //This works for parsing data
            let catIndex = category.index(category.startIndex, offsetBy: 9)
            catCUT = category.substring(to: catIndex)
            print("Test")
            print(catCUT)
        }else{
            catCUT = category
        }
        
        var catSubCUT = ""
        if subCategoryData.characters.count > 9{
            //This works for parsing data
            let catSubIndex = subCategoryData.index(subCategoryData.startIndex, offsetBy: 9)
            catSubCUT = subCategoryData.substring(to: catSubIndex)
            print("Test")
            print(catSubCUT)
        }else{
            catSubCUT = subCategoryData
        }
        
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                print("iPhone 5 or 5S or 5C")
            case 1334:
                print("iPhone 6/6S/7/8")
            case 2208:
                print("iPhone 6+/6S+/7+/8+")
            case 2436:
                print("iPhone X")
                submitTicketText.isHidden = true
            default:
                print("unknown")
            }
        }
        
        //serviceButton
        serviceButton.setTitle(serviceCUT, for: UIControlState.normal)
        
        //categoryButton
        categoryButton.setTitle(catCUT, for: UIControlState.normal)
        
        //categoryButton
        subCategoryButton.setTitle(catSubCUT, for: UIControlState.normal)
        
    }
    
   
    @IBAction func submit(_ sender: Any) {
        printResults();
        indicator.startAnimating()
    }
    
    
    
    func printResults()
    {
        
        
        
        
        
        var userName = ""
        let defaults = UserDefaults.standard
        
        if let name = defaults.string(forKey: "username")
        {
            userName = name
            // Will output "theGreatestName"
        }
        
        
        
        var stringNEW9 = "http://servicesapps.ou.edu/quick-ticket/Sources/QuickTicketBackend.php?assignedTeam=services&user=rhod0974&short=test&email=email&phone=7179031909&long=test&service=Instructional%20Technology&category=Classroom%20Response%20System&sub=Not%20Listed&userIn=rhod0974"
        
        //New
        var stringNEW10 = "http://servicesapps.ou.edu/quick-ticket/Sources/QuickTicketBackend.php?assignedTeam=services"+"&user="+ounetID+"&shorty="+titleOf+"&email="+email+"&phone="+phoneNumber+"&long="+titleOf+"&service="+service+"&category="+category+"&sub="+subCategoryData+"&userIn="+userName+"&buildingFull="+building+"&roomNumber="+roomNumber+"&resolved="+"New&teamAssign=na"
        
        let newLink = stringNEW10.replacingOccurrences(of: " ", with: "%20")
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
                        self.incidentID.text = s
                        print("Test")
                        print("This will test extraction:")
                        print(theMainValue)
                        print("**************************")
                        
                        print("THIS IS S::::: ")
                        print(s)
                        
                        if(theMainValue == "")
                        {
                            self.incidentID.text = "Error Processing Request"
                        }
                        self.submitButton.isHidden = true;
                        self.indicator.stopAnimating()
                        
                    }
                   
                }
                
                
                
        }
        
    }
    
    
    
    
}
