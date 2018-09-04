//
//  NewTicketViewController.swift
//  SidebarMenu
//
//  Created by Eric Rhodes on 2/8/17.
//  Copyright © 2017 AppCoda. All rights reserved.
//
//https://github.com/Alamofire/Alamofire
import Foundation
import UIKit
import Alamofire


class NewTicketViewController: UIViewController{
        
@IBOutlet weak var menuButton: UIBarButtonItem!//Menu Button
    
@IBOutlet var tableView: UITableView!//THIS IS THE TABLE VIEW

    
// cell reuse id (cells that scroll out of view can be reused)
let cellReuseIdentifier = "cell"
    

//VIEW DID LOAD 
override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.isUserInteractionEnabled = true;
    
    if self.revealViewController() != nil {
        menuButton.target = self.revealViewController()
        menuButton.action = "revealToggle:"
        //self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        //self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        self.revealViewController().tapGestureRecognizer()
        self.revealViewController().panGestureRecognizer()

        //self.revealViewController().panGestureRecognizer()

    }
   
    //Add save data here
    let defaults = UserDefaults.standard
    
    //Servie data tempararaly saved
    defaults.set("", forKey: "tempService")
    defaults.set("", forKey: "tempCategory")
    defaults.set("", forKey: "tempSub")
    defaults.set("", forKey: "tempOUNetID")
    defaults.set("", forKey: "tempDescription")
    defaults.set("", forKey: "tempShortDescription")
    defaults.set("", forKey: "tempEmail")
    defaults.set("", forKey: "tempPhoneNumber")
    defaults.set("", forKey: "tempBuilding")
    defaults.set("", forKey: "tempRoomNumber")




  
}


@IBAction func about(_ sender: Any) {
    performSegue(withIdentifier: "subCatagory", sender: sender)
}
    
@IBAction func otherButtonPressed(_ sender: Any) {
    NSLog("Other button was pressed");
}
    
//This sends the post
func sendPost()
{
    
    let json: Parameters = [    "building": "Phone"  ,
                               "assignedTeam":"Services",
                               "username": "rhod0974",
                               "shortDescription": "Test",
                               "longDescription": "Help, need Help",
                               "roomNumber" : "Bizzel Library"]
    
    let json2: [String: Any] = ["building": "Phone",
                            "roomNumber" : "Bizzel Library",
                            "assignedTeam":"Services",
                            "username": "rhod0974",
                            "shortDescription": "Test",
                            "longDescription": "Help, need Help"]
    /*let para = [
        "building" : UserDefaults.standard.value(forKey: "Phone")!,
        "assignedTeam" : UserDefaults.standard.value(forKey: "Services")!,
        "username" : UserDefaults.standard.value(forKey: "rhod0974")!,
        "shortDescription" : UserDefaults.standard.value(forKey: "Test")!,
        "longDescription" : UserDefaults.standard.value(forKey: "Help,needHelp")!,
        "roomNumber" : UserDefaults.standard.value(forKey: "BizzelLibrary")!
    ]*/
    
    print(json);
    
    
    ////*****************THIS WILL BE THE WAY WE DO IT! JUST APPEND THE RIGHT THINGS HERE!!!!**************
    //For version Swift 3.0 and ALamofire v4.0
    var string = "https://servicesapps.ou.edu/chers/QuickTicketBackend.php?building=Bizzel%20Library&roomNumber=Phone&assignedTeam=Services&username=rhod0974&shortDescription=Test&longDescription=help"
    
    var string2 = "https://servicesapps.ou.edu/chers/QuickTicketBackend.php"
    
    
    Alamofire.request(string2, method: .get, encoding: JSONEncoding.default)
        .responseString { response in
            print(response.request)  // original URL request
            print(response.response) // URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
            response.result.error
    }
 
    /*
    Alamofire.request("http://servicesapps.ou.edu/chers/QuickTicketBackend.php", method: .post, parameters: json)
        .responseJSON{ response in
            print(response)
            
            
    }*/
        /*
    Alamofire.request("https://ou.edu/URL_Here", method: .post, parameters: para)
        .responseJSON{ response in
            
          
            
            // Cast response here to whatever format needed.
            if let data = response.result.value as? Dictionary<String, String>{
                
                // Do whatever here with the data
                print(data)
                
            }
    }*/
    /*
    let jsonData = try? JSONSerialization.data(withJSONObject: json)
    
    // create post request
    let url = URL(string: "http://servicesapps.ou.edu/chers/QuickTicketBackend.php")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    
    // insert json data to the request
    request.httpBody = jsonData
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {
            print(error?.localizedDescription ?? "No data")
            return
        }
        let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
        if let responseJSON = responseJSON as? [String: Any] {
            print(responseJSON)
        }
    }
    
    */
    
    
    
}
 
    
    
}
