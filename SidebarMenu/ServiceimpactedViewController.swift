//
//  ServiceimpactedViewController.swift
//  SidebarMenu
//
//  Created by Eric Rhodes on 3/9/17.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import Foundation
import Alamofire

class ServiceTableViewCell: UITableViewCell
{
    @IBOutlet var lable: UILabel!
    
    
}

class ServiceimpactedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var serviceImpactedText: UILabel!
    
    var serviceData: String = "";
    
    var data: [String] = [];
    
    //THIS IS GOING TO BE
    // Data model: These strings will be the data for the table view cells
    let list: [String] = ["Printing", "Device Support", "Classroom AV", "Network", "Email"]
    
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"
    
    
    //Other list
    var otherList: [String] = []
    
    override func viewWillAppear(_ animated: Bool) {
        //splitAndPrint()
        loadServices()
        
    }
    
    //VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        data = ["0","1"];
        
        
        // Register the table view cell class and its reuse id
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        
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
                serviceImpactedText.isHidden = true
            default:
                print("unknown")
            }
        }
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
    }
    
    //Back button was pressed to take you back to the main menu
    @IBAction func backButtonPressed(_ sender: Any) {
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "test") as UIViewController
        
        self.present(controller, animated: false, completion: nil)
        
    }
    
    //This works.. please copy and paste on the next two view controllers
    func addData(s: String)
    {
        otherList.append(s)
    }
    
    //Loads the services from the server
    func loadServices()
    {
        //https://servicesapps.ou.edu/quick-ticket2/Sources/Categories.php?type=2&affected=Device%20Support
        var string = "https://servicesapps.ou.edu/mobileapp/Sources/Categories.php?type=1"
        
        Alamofire.request(string, method: .get, encoding: JSONEncoding.default)
            .responseString { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                
                let services = response.result.value?.characters.split{$0 == ","}.map(String.init)
                
                for s in services!
                {
                    let s_1 = s.replacingOccurrences(of: "]", with: "")
                    let s_2 = s_1.replacingOccurrences(of: "[", with: "")
                    let s_3 = s_2.replacingOccurrences(of: "\"", with: "")
                    //print(s_3)
                    self.addData(s: s_3)
                    self.tableView.reloadData()
                    
                }
                
                
                
        }
        
        
    }
    
    
   
    
    //STILL WORKING ON IT TO GET THE LINES TO SPLIT AND STUFF...
    func splitAndPrint()
    {
        //Gets the file and sets it to a string *contents*
        //let path = Bundle.main.path(forResource: "New Categories", ofType: "txt")// Was "New Categories.txt"
        //let path = Bundle.main.path(forResource: "Categories_v2", ofType: "csv")
        let path = Bundle.main.path(forResource: "Categories2", ofType: "txt")
        
        let contents: NSString
        do {
            contents = try NSString(contentsOfFile: path!, encoding: String.Encoding.utf8.rawValue)
        } catch _ {
            contents = ""
        }
        
        
        var temp = ""
        
        var array = [[String]()]
        
        //Gives the abilty to split
        let stringOfWordsArray = contents.components(separatedBy: "\n")
        
        var newnewTemp = String()
        
        for word in stringOfWordsArray
        {
            
            
            //Array to handle elements of each line
            var array2 = [String]()
            
            //Splits it into an array
            let stringOfWordArray = word.components(separatedBy: ",")
            
            //Removes the "" from the word
            let serv = stringOfWordArray[0].replacingOccurrences(of: "\"", with: "")
            
                
            if(newnewTemp != serv){
                otherList.append((serv as NSObject) as! String)
                newnewTemp = serv
                    
            }
                
            
        }
        
        
    }

    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(serviceData == "")
        {
            
        }
        
        if segue.identifier == "service" {
            
            let toViewController = segue.destination
            if ((toViewController as? CategoryViewController ) != nil){
                NSLog("This is the segue test");
               // toViewController.myData = "Test"
                var cont: CategoryViewController = toViewController as! CategoryViewController
                //cont.service = serviceData //self.list[indexPath.row]
               
                
            }
            
        }
    }
    
    func nextView()
    {
        //Add save data here
        let defaults = UserDefaults.standard
        
        //Servie data tempararaly saved
        defaults.set(serviceData, forKey: "tempService")

        
        performSegue(withIdentifier: "service", sender: AnyObject?.self)
    }
    
    
    @IBAction func nextButtonHit(_ sender: Any) {
        
        //Stores in memory
        let defaults = UserDefaults.standard
        
        // Store
        defaults.set(serviceData, forKey: "tempServiceImpactedData")
        
        // Receive
        if let serviceData = defaults.string(forKey: "tempServiceImpactedData")
        {
            //print(serviceData)
            // Will output "theGreatestName"
        }
        //*****
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.otherList.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:ServiceTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "LableCell") as UITableViewCell! as! ServiceTableViewCell
        
        // set the text from the data model
        cell.lable?.text = self.otherList[indexPath.row]
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        serviceData = otherList[indexPath.row];
        
        nextView()
        
        
    }
    
    
}
