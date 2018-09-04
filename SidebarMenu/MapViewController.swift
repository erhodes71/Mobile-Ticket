//
//  MapViewController.swift
//  SidebarMenu
//
//  Created by Simon Ng on 2/2/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import UIKit
import Alamofire


class TaskTableViewCell: UITableViewCell
{
    @IBOutlet var id: UILabel!
    @IBOutlet var short: UILabel!
    @IBOutlet var long: UILabel!
    

}



class MapViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var menuButton:UIBarButtonItem!
    
    
    @IBOutlet var tableView: UITableView!
    
    
    //Array of the Tasks
    var arrayOfID = [String]()
    var arrayOfLong = [String]()
    var arrayOfShort = [String]()
    var arrayOfIndentification = [String]()
    
    var incidentToGoTo = (String)()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.isUserInteractionEnabled = true;
     
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            //self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.revealViewController().tapGestureRecognizer()
            self.revealViewController().panGestureRecognizer()


        }
        
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
        
        generateTasks();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayOfID.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:TaskTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "LableCell") as UITableViewCell! as! TaskTableViewCell
        
        // set the text from the data model
        cell.id?.text = self.arrayOfID[indexPath.row]
        cell.short?.text = self.arrayOfShort[indexPath.row]
        cell.long?.text = self.arrayOfLong[indexPath.row]
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        //serviceData = list[indexPath.row];
        
        incidentToGoTo = arrayOfIndentification[indexPath.row]
        performSegue(withIdentifier: "webView1", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "webView1") {
            let vc = segue.destination as! TaskWebViewController
            //vc.var_name = "Your Data"
            vc.indentification = incidentToGoTo
        }
    }
    
    
    func generateTasks()
    {
        
        //Loading data in
        let defaults = UserDefaults.standard
        
        
        var userName = ""
        
        if let name = defaults.string(forKey: "username")
        {
            userName = name
            // Will output "theGreatestName"
        }
        

        
        let url: String = "http://servicesapps.ou.edu/mobileapp/Task/TaskList.php?id="+userName;
        //let link = url.replacingOccurrences(of: " ", with: "%20")
        
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default)
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
                
                let json = response.result.value
                
                if let data = json?.data(using: (String.Encoding.utf8)) {
                    let json = JSON(data: data)
                    print(json)
                    var array = json.array
                    
                    
                    //print(array?[0])
                    var count = 0
                    if(array != nil){
                        for element in array!
                        {
                            count += 1
                            
                            if(count%4 == 0 && count != 0)
                            {
                                
                                print("Short Identifiaction:")
                                print(array![count-4])
                                self.arrayOfIndentification.append((String)(describing: array![count-4]))
                                
                                print("Incident Date:")
                                print(array![count-3])
                                self.arrayOfLong.append((String)(describing: array![count-3]))//arrayOfLogin will be date
                                //print(self.arrayOfIncidents)
                                
                                print("ID:")
                                print(array![count-2])
                                self.arrayOfID.append((String)(describing: array![count-2]))
                                //print(self.arrayOfDescription)
                                
                                print("Short Identification:")
                                print(array![count-1])
                                self.arrayOfShort.append((String)(describing: array![count-1]))
                                //print(self.arrayOfDescription)
                                
                                
                                
                            }
                            
                            //count += 1
                        }
                    }
                    
                    if(array?.count == 0){
                        self.arrayOfID.append("NO CURRENT TASKS")
                        self.arrayOfLong.append("NO CURRENT TASKS")
                        self.arrayOfShort.append("NO CURRENT TASKS")

                    }
                    //print("Prints arrays")
                    //print(self.arrayOfIncidents)
                    //print(self.arrayOfDescription)
                    self.tableView.reloadData()
                }

                    
                    
                
               
                
                
        }

    
    }
    

    

}
