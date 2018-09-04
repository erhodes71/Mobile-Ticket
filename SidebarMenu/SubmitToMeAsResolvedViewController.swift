//
//  SubmitToMeAsResolvedViewController.swift
//  SidebarMenu
//
//  Created by Eric Rhodes on 6/19/17.
//  Copyright © 2017 AppCoda. All rights reserved.
//


import Foundation
import Alamofire

class SubmitToMeAsResolvedViewController: UIViewController{
    
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
    
    /*
     var resolveIssue: String!
     var assignToSelf: String!
     var AssignToTeam: String!
     
     var reproduceIssue: String!
     var listStepsTaken: String!
     var customerTroubleShooting: String!
     var helpDeskTroubleShooting: String!
     var desiredOutCome: String!*/
    
    @IBOutlet var incidentID: UILabel!
    
    @IBOutlet var indicator: UIActivityIndicatorView!
    @IBOutlet var submitButton: UIButton!
    
    @IBOutlet weak var serviceButton: UIButton!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var subCategoryButton: UIButton!
    
    @IBOutlet var submitToMeAsResolvedText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Without setting the delegate you won't be able to track UITextView events
        /*NSLog("Service: %s", service);
         NSLog("category: %s", category);
         NSLog("ounetID: %s", ounetID);
         NSLog("titleOf: %s", titleOf);
         NSLog("descriptionOf: %s", descriptionOf);
         NSLog("building: %s", building);
         NSLog("roomNumber: %s", roomNumber);
         NSLog("resolveIssue: %s", resolveIssue);
         NSLog("listStepsTaken: %s", listStepsTaken);
         NSLog("customerTroubleShooting: %s", customerTroubleShooting);
         NSLog("helpDeskTroubleShooting: %s", helpDeskTroubleShooting);
         NSLog("desiredOutCome: %s", desiredOutCome);*/
        //printResults();
        
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
        if service.characters.count > 3{
            //This works for parsing data
            let servIndex = service.index(service.startIndex, offsetBy: 3)
            serviceCUT = service.substring(to: servIndex)
            print("Test")
            print(serviceCUT)
        }else{
            serviceCUT = service
        }
        
        var catCUT = ""
        if category.characters.count > 3{
            //This works for parsing data
            let catIndex = category.index(category.startIndex, offsetBy: 3)
            catCUT = category.substring(to: catIndex)
            print("Test")
            print(catCUT)
        }else{
            catCUT = category
        }
        
        var catSubCUT = ""
        if subCategoryData.characters.count > 3{
            //This works for parsing data
            let catSubIndex = subCategoryData.index(subCategoryData.startIndex, offsetBy: 3)
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
                submitToMeAsResolvedText.isHidden = true
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
        
        //Loading data in
        //let defaults = UserDefaults.standard
        /*
        if let serv = defaults.string(forKey: "tempService")
        {
            service = serv
        }
        
        if let cat = defaults.string(forKey: "tempCategory")
        {
            category = cat
        }
        
        if let catSub = defaults.string(forKey: "tempSub")
        {
            subCategoryData = catSub
        }
        
        //-----//-----//-----//-----//-----
        
        if let OUNetID = defaults.string(forKey: "tempOUNetID")
        {
            ounetID = OUNetID
        }
        
        if let phoneNumber2 = defaults.string(forKey: "tempPhoneNumber")
        {
            phoneNumber = phoneNumber2
        }
        
        if let emailNumber = defaults.string(forKey: "tempEmail")
        {
            email = emailNumber
        }
        
        if let shortDescription = defaults.string(forKey: "tempShortDescription")
        {
            titleOf = shortDescription
        }
        
        if let descript = defaults.string(forKey: "tempDescription")
        {
            descriptionOf = descript
        }
        */
        /*
        NSLog(service);//
        NSLog(category);//
        NSLog(subCategoryData);//
        
        NSLog(ounetID);//
        NSLog(titleOf);//
        NSLog(descriptionOf);//
        NSLog(building);
        NSLog(roomNumber);
        */
        /*NSLog(resolveIssue);
         NSLog(assignToSelf);
         NSLog(AssignToTeam);
         
         NSLog(listStepsTaken);
         NSLog(customerTroubleShooting);
         NSLog(helpDeskTroubleShooting);
         NSLog(desiredOutCome);*/
        
        
        
        /*
        let newTitle = titleOf.replacingOccurrences(of: " ", with: "%20")
        print("New Title")
        print(newTitle)
        
        let newDescription = descriptionOf.replacingOccurrences(of: " ", with: "%20")
        print("New Description")
        print(newDescription)
        
        //Change spaces to %20
        let newService = service.replacingOccurrences(of: " ", with: "%20")
        let newCategory = category.replacingOccurrences(of: " ", with: "%20")
        let newSubCaregory = subCategoryData.replacingOccurrences(of: " ", with: "%20")
        let newBuilding = building.replacingOccurrences(of: " ", with: "%20")
        let newRoomNumber = roomNumber.replacingOccurrences(of: " ", with: "%20")
        
        print("*******************************")
        print(newBuilding)
        print("*******************************")
        */
        
        //http://servicesapps.ou.edu/chers/Quick_Ticket/Sources/QuickTicketBackend.php?assignedTeam=Services&user=rhod0974&short=title&email=email&phone=123&long=Test&service=Instructional%20Technology&category=Lab%20Software&sub=New%20Lab%20software&userIn=rhod0974
        
        //var string = "http://servicesapps.ou.edu/chers/Quick_Ticket/QuickTicketBackend.php?building=Bizzel%20Library&roomNumber=Phone&assignedTeam=Services&user=rhod0974&short=Test&long=help&sub=Duplicate&service=Printing&category=Non case"
        
        
       // var string4 = "http://servicesapps.ou.edu/chers/Quick_Ticket/QuickTicketBackend.php?user=rhod0974&short=Test&long=help&phone=1234543&service=Email&category=Technical Support&sub=Technical Support&email=erhodes71@gmail.com"
        
        
        //Ideal
        /*var string3 = "http://servicesapps.ou.edu/chers/Quick_Ticket/QuickTicketBackend.php?user="+ounetID+"&building="+building+"&roomNumber="+roomNumber+"&short="+titleOf+"&long="+descriptionOf+"&service="+service+"&category="+category+"&sub="+subCategoryData+"&phone="+"7179031909"+"&email="+"erhodes71@gmail.com"
        */
        
        //var string2 = "https://servicesapps.ou.edu/chers/QuickTicketBackend.php"
        
        
        //var stringTest = "http://servicesapps.ou.edu/chers/Quick_Ticket/QuickTicketBackend.php?assignedTeam=Services&username=rhod0974&short=Test&long=help&service=Email&category=Service Access&sub=Account Unlock"
        
        //var stringIF = "http://servicesapps.ou.edu/chers/Quick_Ticket/QuickTicketBackend.php?building=Bizzel%20Library&roomNumber=Phone&assignedTeam=Services&username=rhod0974&shortDescription=Test&longDescription=help"
        
        //THIS WORKS!!!!KEEP LIKE THIS
        //var stringNEW = "http://servicesapps.ou.edu/chers/Quick_Ticket/QuickTicketBackend.php?building=Bizzel%20Library&roomNumber=Phone&assignedTeam=Services&user=rhod0974&short=Test&long=help&service=Device%20Support&category=Technical%20Support&sub=Technical%20Support"
        /*
        var userName = ""
        //let defaults = UserDefaults.standard
        
        if let name = defaults.string(forKey: "username")
        {
            userName = name
            // Will output "theGreatestName"
        }
        */
        //"http://servicesapps.ou.edu/chers/Quick_Ticket/Sources/QuickTicketBackend.php?assignedTeam=Services"+&user="+"rhod0974"+"&short="+"title"+"&email="+"email"+"&phone="+"123"+"&long="+"Test"+"&service="+"Instruction%20Technology"+"&category="+"Lab%20Software"+"&sub="+"New%20Lab%20software"+"&userIn="+"rhod0974"
        
        
        //ADD THE NEW ID TO THIS STRING...
        //ADD SOURCES AFTER QUICK TICKET
        //WORKS BUT MAKE SURE %20 for space // KEEP SELECTION STATIC NOW UNTIL FIX POPULATE ISSUE
        /*var stringNEW2 = "http://servicesapps.ou.edu/chers/Quick_Ticket/Sources/QuickTicketBackend.php?buildingFull="+newBuilding+"&roomNumber="+newRoomNumber+"&assignedTeam=Services&user="+ounetID+"&short="+newTitle+"&email="+email+"&phone="+phoneNumber+"&long="+newDescription+"&service="+newService+"&category="+newCategory+"&sub="+newSubCaregory+"&userIn="+userName
        */
        //var user = "rhod0974"
        
        //var stringNEW3 = "http://servicesapps.ou.edu/chers/Quick_Ticket/Sources/QuickTicketBackend.php?building=Bizzel%20Library&roomNumber=Phone&assignedTeam=Services&user=rhod0974&short=help&long=help&service=Device%20Support&category=Technical%20Support&sub=Technical%20Support&userIn=rhod0974"
        //print("Title")
        //print(titleOf)
        
        
        /*var stringNEW7 = "http://servicesapps.ou.edu/chers/Quick_Ticket/Sources/QuickTicketBackend.php?buildingFull="+newBuilding+"&roomNumber="+newRoomNumber+"&assignedTeam=services&user="+ounetID+"&short="+newTitle+"&email="+email+"&phone="+phoneNumber+"&long="+newDescription+"&service="+"Instructional%20Technology"+"&category="+"Lab%20Software"+"&sub="+"New%20Lab%20software"+"&userIn="+userName
        */
        //These are tests
        //var stringNEW8 = "http://servicesapps.ou.edu/chers/Quick_Ticket/Sources/QuickTicketBackend.php?assignedTeam=services&user=rhod0974&short=test&email=email&phone=7179031909&long=test&service=Instructional%20Technology&category=Lab%20Software&sub=New%20Lab%20software&userIn=userName"
        
        //var stringNEW9 = "http://servicesapps.ou.edu/quick-ticket/Sources/QuickTicketBackend.php?assignedTeam=services&user=rhod0974&short=test&email=email&phone=7179031909&long=test&service=Instructional%20Technology&category=Classroom%20Response%20System&sub=Not%20Listed&userIn=rhod0974"
        
        
        //http://servicesapps.ou.edu/chers/Quick_Ticket/Sources/QuickTicketBackend.php?&roomNumber=123&assignedTeam=services&user=rhod0974&short=newTitle&email=email&phone=123&long=newDescription&service=Instructional%20Technology&category=Lab%20Software&sub=New%20Lab%20software&userInrhod0974
        
        
        //let TESTET = "servicesapps.ou.edu/chers/Quick_Ticket/Sources/Sub_Categories.php?get=Email//Technical%20Support"
        
        
        //NOTE: Need to make sure you put %20 as space because it wont work if you dont do that!
        
        
        //var first: String = "http://servicesapps.ou.edu/chers/Quick_Ticket/QuickTicketBackend.php?building=Bizzel%20Library&roomNumber=Phone&assignedTeam=Services&user=rhod0974&short="
        
        //var second: String = "&long=help&service=Device%20Support&category=Technical%20Support&sub=Technical%20Support"
        
        //var final: String = first + titleOf + second
        
        //print("This is the new string")
        //print(final)
        
        //For Later
        //https://servicesapps.ou.edu/chers/Quick_Ticket/Sub_Categories.php?get=Email//Technical%20Support
        
        //var JSON1 = ""
        
        var userName = ""
        let defaults = UserDefaults.standard
        
        if let name = defaults.string(forKey: "username")
        {
            userName = name
            // Will output "theGreatestName"
        }
        
        var stringNEW9 = "http://servicesapps.ou.edu/mobileapp/Sources/QuickTicketBackend.php?assignedTeam=services&user=rhod0974&short=test&email=email&phone=7179031909&long=test&service=Instructional%20Technology&category=Classroom%20Response%20System&sub=Not%20Listed&userIn=rhod0974"
        
        //New
        var stringNEW10 = "http://servicesapps.ou.edu/mobileapp/Sources/QuickTicketBackend.php?assignedTeam=services"+"&user="+ounetID+"&shorty="+titleOf+"&email="+email+"&phone="+phoneNumber+"&long="+titleOf+"&service="+service+"&category="+category+"&sub="+subCategoryData+"&userIn="+userName+"&buildingFull="+building+"&roomNumber="+roomNumber+"&resolved="+"Resolved"+"teamAssign=na"
        
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
                
                //DO IT KINDA THIS WAY WHEN YOU FIGURE IT OUT...
                
                /*
                 switch response.result {
                 case .success(let data):
                 let json = JSON(data)
                 let name = json["busObPublicId"].stringValue
                 print(name)
                 print("Test")
                 case .failure(let error):
                 print("Request failed with error: \(error)")
                 }
                 */
                
                if let json = response.result.value {
                    print("JSON: \(json)")
                    
                    
                    
                    
                    
                    
                    //let json2 = JSON(json)
                    //print(json["busObPublicId"].stringValue)
                    
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
                        
                        /*
                         for item in json.arrayValue {
                         print("Here")
                         print(item["busObPublicId"].stringValue)
                         }*/
                        
                        self.indicator.stopAnimating()
                        self.submitButton.isHidden = true;
                    }
                    
                    
                    //This isnt working...
                    /*
                     let s = json2["busObPublicId"].stringValue
                     
                     
                     for result in json2["busObPublicId"].arrayValue {
                     print("Test")
                     
                     }
                     
                     incidentNumber = s
                     
                     print("This is the new incidentNumber")
                     NSLog(incidentNumber)
                     */
                    //var json2 = JSON(data: data)
                    
                    
                }
                
                
                //response.result.error//15-21
                
                
                
                //to get status code
                /*
                 if let status = response.response?.statusCode {
                 switch(status){
                 case 201:
                 print("example success")
                 default:
                 print("error with response status: \(status)")
                 }
                 }
                 //to get JSON return value
                 if let result = response.result.value {
                 let JSON = result as! NSDictionary
                 print(JSON)
                 print("Test")
                 }
                 */
                
                
        }
        
        
        /*
         var dictonary:NSDictionary?
         
         if let data = JSON1.data(using: String.Encoding.utf8) {
         do {
         dictonary =  try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] as NSDictionary?
         if let myDictionary = dictonary
         {
         print(" First name is: \(myDictionary["first_name"]!)")
         }
         } catch let error as NSError {
         print(error)
         }
         }
         */
        
        
        //let blogs = JSON1["blogs"] as? [[String: Any]]
        
        //JSON1.contains("busObPulbicId")
        //http://stackoverflow.com/questions/38053106/how-to-parse-the-json-data-using-swiftjson-along-with-alamofire
        
        //THIS MIGHT BE HELPFUL
        //https://www.hackingwithswift.com/read/7/3/parsing-json-data-and-swiftyjson
        
        
        //THIS ACTUALLY SHOULD WORK!!!
        //http://roadfiresoftware.com/2016/12/how-to-parse-json-with-swift-3/ <---
        
        //[{"busObPublicId":"39183","busObRecId":"94243f79b86abd0aac31254e7f9b93ca2693cc3155","fieldValidationErrors":[],"errorCode":null,"errorMessage":null,"hasError":false}]
        
        //var check = JSON1[""]
    }
    
    
    
    
}

