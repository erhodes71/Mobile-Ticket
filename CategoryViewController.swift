//
//  CategoryViewController.swift
//  SidebarMenu
//
//  Created by Eric Rhodes on 3/8/17.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import Foundation
import Alamofire

class CateogryTableViewCell: UITableViewCell
{
    //https://www.ralfebert.de/tutorials/ios-swift-uitableviewcontroller/custom-cells/ <-- INFO ON THE CELLS
    @IBOutlet var lable: UILabel!
    
    
}


class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    
    
    @IBOutlet var lableForType: UILabel!
    
    @IBOutlet weak var serviceButton: UIButton!
    
    
    let list: [String] = ["Non case", "Service Documentation and Assistance", "Service Requests", "Technical Support"]
    
    //List for printing
    let printingList: [String] = ["Non case", "Service Access", "Service Documentation and Assistance", "Service Interruptions", "Service Requests", "Technical Support"]
    
    //List for device support
    let deviceSupportList: [String] = ["Non case", "Service Documentation and Assistance","Service Requests", "Technical Support"]
    
    //List for classroom AV
    let classroomAVList: [String] = ["Non case", "Service Documentation and Assistance", "Service Interruptions", "Service Requests", "Technical Support"]
    
    //List for network
    let networkList: [String] = ["Non case", "Service Access", "Service Documentation and Assistance", "Service Interruptions", "Service Requests", "Technical Support"]
    
    //List for the email
    let emailList: [String] = ["Non case", "Scheduled Maintenance","Service Access", "Service Documentation and Assistance", "Service Interruptions", "Service Requests", "Technical Support"]
    
    
    //Other list
    var otherList: [String] = []
    
    @IBOutlet var categoryText: UILabel!
    
    var service: String!
    
    var categoryData: String = "";
    
    @IBOutlet var tableView: UITableView!
    
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"

    //Before Appear
    override func viewWillAppear(_ animated: Bool) {
        //splitAndPrint()
        loadServices()
        
    }

    //VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Loading data in
        let defaults = UserDefaults.standard
        
        if let serv = defaults.string(forKey: "tempService")
        {
            service = serv
        }
        
        //serviceButton
        serviceButton.setTitle(service, for: UIControlState.normal)
        
        
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
                categoryText.isHidden = true
            default:
                print("unknown")
            }
        }
        
        
        tableView.delegate = self
        tableView.dataSource = self

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "category" {
            
            let toViewController = segue.destination
            if ((toViewController as? subCategory ) != nil){
                
                let cont: subCategory = toViewController as! subCategory
                
                
                
            }
            
        }
    }
    
    func printThings()
    {
        NSLog(service);
        
    
    }
    
    func addData(s: String)
    {
        otherList.append(s)
    }
    
    //Loads the services from the server
    func loadServices()
    {
        //https://servicesapps.ou.edu/quick-ticket2/Sources/Categories.php?type=2&affected=Device%20Support
        //var string = "https://servicesapps.ou.edu/quick-ticket2/Sources/Categories.php?type=2&affected=Service"
        print("Service:")
        print(service)//Email & Calendar
        var serviceAlteredWithAnd = service.replacingOccurrences(of: "&", with: "%26")
        var serviceAlteredWithSpace = serviceAlteredWithAnd.replacingOccurrences(of: " ", with: "%20")
        var string = String(format: "https://servicesapps.ou.edu/quick-ticket2/Sources/Categories.php?type=2&affected=%@", serviceAlteredWithSpace)
        print(string)
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
    
    
    func splitAndPrint()
    {
        
        //Gets the file and sets it to a string *contents*
        //let path = Bundle.main.path(forResource: "New Categories", ofType: "txt")
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
            //print(word)
            //print("\n\n")
            
            if(word != ""){
            //Array to handle elements of each line
            var array2 = [String]()
            
            //Splits it into an array
            let stringOfWordArray = word.components(separatedBy: ",")
            
            
            
            //GOT RID OF THE ""
            let serv = stringOfWordArray[0].replacingOccurrences(of: "\"", with: "")
            let cat = stringOfWordArray[1].replacingOccurrences(of: "\"", with: "")
           
            
            
            if(serv == service)
            {
                
                //print("GOT IT")
                print(serv)
                print(cat)
                //stack.push(v: stringOfWordArray[2] as NSObject)
                
                if(newnewTemp != cat){
                    otherList.append((cat as NSObject) as! String)
                    newnewTemp = cat
                
                }
                
            }
            
            }
            
            /*
             for newWord in stringOfWordArray
             {
             
             print(newWord)
             array2.append(newWord)
             /*
             if(newWord == temp)
             {
             break
             }
             temp = newWord
             print(newWord)*/
             
             
             }
             
             array.append(array2)
             */
        }
        
        //Gets all the appropiate subcategory
        //while(!stack.isEmpty())
        //{
        //print(stack.pop() ?? String())
        //}
        
        
        
    }

    
    func nextView()
    {
        //Add save data here
        let defaults = UserDefaults.standard
        
        //Servie data tempararaly saved
        defaults.set(categoryData, forKey: "tempCategory")
        
        performSegue(withIdentifier: "category", sender: AnyObject?.self)
        
    }
    
    
    @IBAction func otherButtonPressed(_ sender: Any) {
        //NSLog("Other Button Pressed");
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.otherList.count
        /*
        var num : Int  = 0;
        
        if(service == "Printing")
        {
            //categoryData = printingList[indexPath.row]
            num = self.printingList.count
        }else if(service == "Device Support")
        {
            //categoryData = deviceSupportList[indexPath.row]
            num = self.deviceSupportList.count
        }else if(service == "Classroom AV")
        {
            //categoryData = classroomAVList[indexPath.row]
            num = self.classroomAVList.count
        }else if(service == "Network")
        {
            //categoryData = networkList[indexPath.row]
            num = self.networkList.count
        }else if(service == "Email")
        {
            //categoryData = emailList[indexPath.row]
            num = self.emailList.count
        }
        
        return num*/
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:CateogryTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "LableCell") as UITableViewCell! as! CateogryTableViewCell
        
        // set the text from the data model
        cell.lable?.text = self.otherList[indexPath.row]
        
        /*
        if(service == "Printing")
        {
            cell.lable?.text = printingList[indexPath.row]
        }else if(service == "Device Support")
        {
            cell.lable?.text = deviceSupportList[indexPath.row]
        }else if(service == "Classroom AV")
        {
            cell.lable?.text = classroomAVList[indexPath.row]
        }else if(service == "Network")
        {
            cell.lable?.text = networkList[indexPath.row]
        }else if(service == "Email")
        {
            cell.lable?.text = emailList[indexPath.row]
        }
        
        printThings();*/
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        categoryData = otherList[indexPath.row];
        /*
        if(service == "Printing")
        {
            categoryData = printingList[indexPath.row]
        }else if(service == "Device Support")
        {
            categoryData = deviceSupportList[indexPath.row]
        }else if(service == "Classroom AV")
        {
            categoryData = classroomAVList[indexPath.row]
        }else if(service == "Network")
        {
            categoryData = networkList[indexPath.row]
        }else if(service == "Email")
        {
            categoryData = emailList[indexPath.row]
        }*/
        
        nextView()
        
    }



}
