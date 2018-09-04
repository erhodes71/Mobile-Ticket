//
//  HistoryViewController.swift
//  SidebarMenu
//
//  Created by Eric Rhodes on 4/13/17.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import Foundation
import Alamofire


class HistoryTableViewCell: UITableViewCell
{
    //https://www.ralfebert.de/tutorials/ios-swift-uitableviewcontroller/custom-cells/ <-- INFO ON THE CELLS
    @IBOutlet var Incidentlable: UILabel!
    
    @IBOutlet var descriptionLable: UILabel!
    
    @IBOutlet var statusLable: UILabel!
    
    @IBOutlet var theDate: UILabel!
    
}

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    //Array of INC and Descriptions
    var arrayOfIncidents = [String]()
    var arrayOfDescription = [String]()
    var arrayOfStatus = [String]()
    var arrayOfDates = [String]()
    var arrayOfIDs = [String]()
    
    
    var incidentToGoTo  = (String)()

    //This is for the button
    @IBOutlet var menuButton: UIBarButtonItem!
    
    @IBOutlet var tableView: UITableView!
    
    // Data model: These strings will be the data for the table view cells
    //CHANGE THIS TO A LOADED DATA ARRAY
    let list: [String] = ["Printing", "Device Support", "Classroom AV", "Network", "Email"]
    
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        arrayOfIncidents.removeAll()
        arrayOfDescription.removeAll()
        arrayOfStatus.removeAll()
        arrayOfDates.removeAll()
        arrayOfIDs.removeAll()

        //Gets list of Incidents
        getListOfIncidents()
        
        print("GETS LIST OF INCIDENTS")
        
        print(arrayOfIncidents)
        print(arrayOfDescription)
        print(arrayOfStatus)
        print(arrayOfDates)
        print(arrayOfIDs)
        print("TEST 1 ------------------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
    
    }
    
    
    
    
    //VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.isUserInteractionEnabled = true;
        
        
        //THIS IS USED FOR THE MENU
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            //self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.revealViewController().tapGestureRecognizer()
            self.revealViewController().panGestureRecognizer()


        }
        
        // Register the table view cell class and its reuse id
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //User auth
        let defaults = UserDefaults.standard
        
        let stringOne = defaults.string(forKey: "auth")
        if(stringOne == "" || stringOne == "0")
        {
            //Send to log in
            performSegue(withIdentifier: "webView", sender: self)
            
        }else if(stringOne == "1"){
            //Do nothing
            
        }

        
    }
    
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayOfIncidents.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:HistoryTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "LableCell") as UITableViewCell! as! HistoryTableViewCell
        
        // set the text from the data model
        cell.Incidentlable?.text = self.arrayOfIncidents[indexPath.row]
        cell.descriptionLable?.text = self.arrayOfDescription[indexPath.row]
        cell.theDate?.text = self.arrayOfDates[indexPath.row]
        cell.statusLable?.text = self.arrayOfStatus[indexPath.row]
        
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        //serviceData = list[indexPath.row];
        incidentToGoTo = arrayOfIDs[indexPath.row]
        performSegue(withIdentifier: "webView1", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "webView1") {
            let vc = segue.destination as! IncidentWebViewController
            //vc.var_name = "Your Data"
            vc.indentification = incidentToGoTo
        }
    }
    
    func getListOfIncidents()
    {
        //Loading data in
        let defaults = UserDefaults.standard
        
        
        var userName = ""
        var password = ""
        
        if let name = defaults.string(forKey: "username")
        {
            userName = name
            // Will output "theGreatestName"
        }
        
        if let pass = defaults.string(forKey: "password")
        {
            password = pass
            // Will output "theGreatestName"
        }

        
        
        //New
        var url = "http://servicesapps.ou.edu/mobileapp/Incident/IncidentList.php?id="+userName
        
        let link = url.replacingOccurrences(of: " ", with: "%20")
        
        
        
        Alamofire.request(link, method: .get, encoding: JSONEncoding.default)
            .responseString { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                
                
                
                let json = response.result.value
                
                if let data = json?.data(using: (String.Encoding.utf8)) {
                    let json = JSON(data: data)
                    print(json)
                    var array = json.array
                    
                    
                    var count = 0
                    if(array != nil){
                    for element in array!
                    {
                        
                        count += 1
                        
                        if(count%5 == 0 && count != 0)
                        {
                            print("Incident Number:")
                            print(array?[count - 5])
                            self.arrayOfIncidents.append((String)(describing: array![count - 5]))
                            print(self.arrayOfIncidents)
                            
                            print("Status:")
                            print(array?[count - 4])
                            self.arrayOfStatus.append((String)(describing: array![count - 4]))
                            print(self.arrayOfStatus)
                            
                            print("Date:")
                            print(array?[count - 3])
                            self.arrayOfDates.append((String)(describing: array![count - 3]))
                            print(self.arrayOfDates)
                            
                            print("Description:")
                            print(array?[count - 2])
                            self.arrayOfDescription.append((String)(describing: array![count - 2]))
                            print(self.arrayOfDescription)
                            
                            print("ID:")
                            print(array?[count - 1])
                            self.arrayOfIDs.append((String)(describing: array![count - 1]))
                            print(self.arrayOfIDs)
                            
                        }
                        
                        
                    
                    }

                    
                    }
                    
                    if(array?.count == 0){
                    
                        
                        self.arrayOfIncidents.append("NO CURRENT INCIDENTS")
                        self.arrayOfDescription.append("NO CURRENT INCIDENTS")
                        self.arrayOfDates.append("NO CURRENT INCIDENTS");
                        self.arrayOfStatus.append("NO CURRENT INCIDENTS");
                        
                    }
                    print("Prints arrays")
                    print(self.arrayOfIncidents)
                    print(self.arrayOfDescription)
                    print(self.arrayOfStatus)
                    print(self.arrayOfDates)
                    print(self.arrayOfIDs)
                    self.tableView.reloadData()
                }
                
                
        }
        
        
    }


}
