//
//  subCategory.swift
//  SidebarMenu
//
//  Created by Eric Rhodes on 3/20/17.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import Alamofire
import Foundation


//Stack Node
class node
{
    var value: NSObject?
    var next: node?
    
    
    
    init() {
        
    }
    
    init(value: NSObject) {
        self.value = value
        self.next = node()
    }
    
}

//Stack Class
class Stack
{
    var count: Int = 0
    var head: node = node()
    
    init()
    {
        
    }
    
    func isEmpty() -> Bool
    {
        if(self.count == 0)
        {
            return true
        }else{
            return false
        }
    }
    
    func push(v: NSObject) {
        if isEmpty() {
            self.head = node()
        }
        
        let node1 = node(value: v)
        node1.next = self.head
        self.head = node1
        self.count += 1
    }
    
    
    
    func pop() -> NSObject? {
        if isEmpty() {
            return nil
        }
        
        let node = self.head
        self.head = node.next!
        self.count -= 1
        
        return node.value
    }
    
    func peek() -> NSObject? {
        if isEmpty() {
            return nil
        }
        
        let node = self.head
        
        return node.value
    }



}







class SubCateogryTableViewCell: UITableViewCell
{
    //https://www.ralfebert.de/tutorials/ios-swift-uitableviewcontroller/custom-cells/ <-- INFO ON THE CELLS
    @IBOutlet var lable: UILabel!
    
    
    
    
}


class subCategory: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    
    @IBOutlet var lableForType: UILabel!

    @IBOutlet weak var serviceButton: UIButton!
    @IBOutlet weak var categoryButton: UIButton!
    
    
    let list: [String] = ["Non case", "Service Documentation and Assistance", "Service Requests", "Technical Support"]
    
    let newList: [String] = []
    
    let printingList: [String] = ["Non case", "Service Documentation and Assistance", "Service Requests", "Technical Support"]
    
    //let printingListSub: [String] = [["Duplicate"],["Billing Inquiry","Provided Assistance / Documentation"]
    
    
   
    let contents = "/Users/samallen/file.txt"
    
    //Other list
    var otherList: [String] = []
        
    @IBOutlet var subCategoryText: UILabel!
    
    var service: String!
    var categoryData: String!
    var subCategoryData: String = "";
    
    var stack = Stack()
    
    
    @IBOutlet var tableView: UITableView!
    
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"
    
    override func viewWillAppear(_ animated: Bool) {
        //splitAndPrint()
        loadServices()
        //otherList = [String?](repeating: nil, count:stack.count) as! [String]
        //let first = stack.pop()
        //let second = stack.pop()
        //let third = stack.pop()
        //otherList.append(first as! String)
        //otherList.append(second as! String)
        //otherList.append(third as! String)
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
        
        if let catt = defaults.string(forKey: "tempCategory")
        {
            categoryData = catt
        }
        
        
        var serviceCUT = ""
        if service.characters.count > 20{
        //This works for parsing data
        let servIndex = service.index(service.startIndex, offsetBy: 20)
        serviceCUT = service.substring(to: servIndex)
        print("Test")
        print(serviceCUT)
        }else{
            serviceCUT = service
        }
        
        var catCUT = ""
        if categoryData.characters.count > 20{
        //This works for parsing data
        let catIndex = categoryData.index(categoryData.startIndex, offsetBy: 20)
        catCUT = categoryData.substring(to: catIndex)
        print("Test")
        print(catCUT)
        }else{
            catCUT = categoryData
        }
        //var serviceSplit = service.components(separatedBy: "")
        //var serviceMake = ""
        
        
        
        //serviceButton
        serviceButton.setTitle(serviceCUT, for: UIControlState.normal)
        
        //categoryButton
        categoryButton.setTitle(catCUT, for: UIControlState.normal)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
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
                subCategoryText.isHidden = true
            default:
                print("unknown")
            }
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //lableForType.text = categoryData
        
        //printThings();
        //getAppropriateList();
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "subCategory" {
            
            let toViewController = segue.destination
            if ((toViewController as? CustomerInfo ) != nil){
                //NSLog("This is the segue test");
                // toViewController.myData = "Test"
                let cont: CustomerInfo = toViewController as! CustomerInfo
                //cont.service = service
                //cont.category = categoryData
                //cont.subCategoryData = subCategoryData
                
                
                
            }
            
        }
        
        if segue.identifier == "recategory" {
            
            let toViewController = segue.destination
            if ((toViewController as? CategoryViewController ) != nil){
                //NSLog("This is the segue test");
                // toViewController.myData = "Test"
                let cont: CategoryViewController = toViewController as! CategoryViewController
                //cont.service = service
                
                
                
                
            }
            
        }
    }
    
    @IBAction func testButtonPressed(_ sender: Any) {
        
        //getAppropriateList();
        splitAndPrint()
    }
    
    
    func nextView()
    {
        //Add save data here
        let defaults = UserDefaults.standard
        
        //Servie data tempararaly saved
        defaults.set(subCategoryData, forKey: "tempSub")
        
        performSegue(withIdentifier: "subCategory", sender: AnyObject?.self)
        
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
        
        var categoryAlteredWithAnd = categoryData.replacingOccurrences(of: "&", with: "%26")
        var categoryAlteredWithSpace = categoryAlteredWithAnd.replacingOccurrences(of: " ", with: "%20")
        
        var string = String(format: "https://servicesapps.ou.edu/quick-ticket2/Sources/Categories.php?type=3&affected=%@&category=%@", serviceAlteredWithSpace, categoryAlteredWithSpace)
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
    
    
    func getAppropriateList()
    {
    
        //NEED THE APPROPRIATE STRING* GOT IT
        //GET SCOTT TO RE WRITE THIS SO THAT IT CAN WORK FOR YOU LIKE THE REST OF THE NO // but have the &
        
        let string = "servicesapps.ou.edu/chers/Quick_Ticket/Sources/Sub_Categories.php?get=Email//Technical%20Support"
        //let string2 = "servicesapps.ou.edu/chers/Quick_Ticket/Sources/Sub_Categories.php?get"
        
        
        
        /*
        let urlString = URL(string: "servicesapps.ou.edu/chers/Quick_Ticket/Sources/Sub_Categories.php?get=Email//Technical%20Support")
        if let url = urlString {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error)
                } else {
                    if let usableData = data {
                        print(usableData)
                    }
                }
            }
            task.resume()
        }*/
        
        //THIS IS A TEST
        
        
        
        
        
        //SOMETHING IS NOT WORKIN HERE...JSONEncoding
        Alamofire.request(string, method: .get, encoding: JSONEncoding.default)
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
                    /*->
                    if let data = json.data(using: (String.Encoding.utf8)) {
                        let json = JSON(data: data)
                        print("Test")
                        print(json)
                        var v = json.dictionary
                        
                        //let q = v?.first?.key //This returns the key!
                        //let q = v?.first?.value
                        //let q = v?.index(forKey: "errorCode")
                        let q = v?.index(forKey: "errorCode")
                        let b = v?.popFirst()
                        let c = v?.popFirst()
                        let d = v?.popFirst()
                        let e = v?.popFirst()
                        //let t = q?.value
                        print(e)
                        let s = e!.value.stringValue
                        print(s)//FINALLY WORKS
                        self.incidentID.text = s
                        print("Test")
                        ->*/
                        /*
                         for item in json.arrayValue {
                         print("Here")
                         print(item["busObPublicId"].stringValue)
                         }*/
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

    
    }
    
    func printThings()
    {
        //NSLog(service);
        
        
    }
    
    //STILL WORKING ON IT TO GET THE LINES TO SPLIT AND STUFF...
    func splitAndPrint()
    {
        //Stack for later
        //let stack = Stack()
        
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
        
        //print(contents)
        
        var temp = ""
        
        var array = [[String]()]
        
        //Gives the abilty to split
        let stringOfWordsArray = contents.components(separatedBy: "\n")
        
        for word in stringOfWordsArray
        {
            //print(word)
            //print("\n\n")
            
            if(word != ""){
            //Array to handle elements of each line
            var array2 = [String]()
            
            //Splits it into an array
            let stringOfWordArray = word.components(separatedBy: ",")
            
            //Prints the first element of this array A.K.A. the service impacted
            //print(stringOfWordArray[0])
            //print(stringOfWordArray[1])

            //GOT RID OF THE ""
            let serv = stringOfWordArray[0].replacingOccurrences(of: "\"", with: "")
            let cat = stringOfWordArray[1].replacingOccurrences(of: "\"", with: "")
            
            let subCat = stringOfWordArray[2].replacingOccurrences(of: "\"", with: "")
            
            if(serv == service && cat == categoryData)
            {
            
                //print("GOT IT")
                //print(serv)
                //print(cat)
                //stack.push(v: stringOfWordArray[2] as NSObject)
                otherList.append((subCat as NSObject) as! String)
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
    
    
    @IBAction func otherButtonPressed(_ sender: Any) {
        //NSLog("Other Button Pressed");
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return self.list.count
        return self.otherList.count
        //return stack.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:SubCateogryTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "LableCell") as UITableViewCell! as! SubCateogryTableViewCell
        
        // set the text from the data model
        //cell.lable?.text = self.list[indexPath.row]
        cell.lable?.text = self.otherList[indexPath.row]
        //cell.lable?.text = stack.peek() as! String?
        //printThings();
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        //subCategoryData = list[indexPath.row];
        subCategoryData = otherList[indexPath.row];
        //subCategoryData = (stack.peek() as! String?)!
        nextView()
    }
    
    
    
}

