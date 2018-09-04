//
//  AdditionalInformationViewController.swift
//  SidebarMenu
//
//  Created by Eric Rhodes on 3/8/17.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class AdditionalInfoTableViewCell: UITableViewCell
{
    @IBOutlet var lable: UILabel!

}


class AdditionalInformationViewController: UIViewController, UITextViewDelegate, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{

    @IBOutlet var bodyText: UITextView!
    
    
    var service: String!
    var category: String!
    var subCategoryData: String!
    
    var ouNetID2: String!
    var email2: String!
    var p: String!

    
    var activeField: UITextField?
    
    @IBOutlet var ouNetID: UITextField!
    @IBOutlet var shortDescription: UITextField!
   
    @IBOutlet var building: UITextField!
    @IBOutlet var roomNumber: UITextField!
    
    @IBOutlet var email: UITextField!
    @IBOutlet var phoneNumber: UITextField!
    
    @IBOutlet var popUpView: UIView!
    
   
    @IBOutlet var locations: UITableView!
    
    @IBOutlet var searchBar: UISearchBar!
    
    //Error messages
    @IBOutlet var requiredFields: UILabel!
    @IBOutlet var star1: UILabel!
    @IBOutlet var star2: UILabel!
    
    @IBOutlet weak var serviceButton: UIButton!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var subCategoryButton: UIButton!
    @IBOutlet weak var customerInformationButton: UIButton!
    
    
    
    
    
    @IBOutlet var TicketInfoText: UILabel!
    
    
    
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"
    
    var list: [String] = ["Non case", "Service Documentation and Assistance", "Service Requests", "Technical Support"]
    
    //Buildings list
    var buildings: [String] = []
    var searchActive : Bool = false
    var filteredBuildings: [String] = []
    
    var keyBoardIsUp: Bool = false;
    
    var popUpIsUP : Bool = false
    
    
    override func viewWillAppear(_ animated: Bool) {
        //Loads The data IN
        loadLocationData()
        
        
        
        
        
        //self.filteredBuildings = buildings.filter{ $0.contains("Evans") }
        print("TEST FOR BUILDINGS VIEW DID LOAD***************************************************************************************")
        print(buildings)
        
        //print("******************FILTERED BUILDINGS********************")
        //print(filteredBuildings)
        //self.filteredBuildings = buildings.filter{ $0.contains("Evans") }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        star1.isHidden = true
        star2.isHidden = true
        requiredFields.isHidden = true

       
        
        //print("TEST FOR BUILDINGS VIEW DID LOAD***************************************************************************************")
        //print(buildings)
        
        bodyText.delegate = self //Without setting the delegate you won't be able to track UITextView events
        
        // Register the table view cell class and its reuse id
        self.locations.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        
        locations.delegate = self
        locations.dataSource = self
        searchBar.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
        let tap = UITapGestureRecognizer(target: self.view, action: Selector("endEditing:"))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        popUpIsUP = false;
        popUpView.removeFromSuperview()
        
        let defaults = UserDefaults.standard

        if var name = defaults.string(forKey: "autoFill")
        {
            if(name == "false")
            {
                
            }else if(name == "true")
            {
                var shortDes = defaults.string(forKey: "shortDescription")
                var longDes = defaults.string(forKey: "longDescription")
                
                shortDescription.text = shortDes
                bodyText.text = longDes
            }
        }
        
        //let defaults = UserDefaults.standard
        
        
        if let serv = defaults.string(forKey: "tempService")
        {
            service = serv
        }
        
        if let catt = defaults.string(forKey: "tempCategory")
        {
            category = catt
        }
        
        if let subCatt = defaults.string(forKey: "tempSub")
        {
            subCategoryData = subCatt
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
                TicketInfoText.isHidden = true
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
        
        //loadLocationData()
        //self.view.addSubview(popUpView)
        print(buildings)
    }
    
    func reverseBuildingList()
    {
        print("****************************TEST FOR REVERSE****************************")
        print("************************************************************************")
        print("************************************************************************")
        print("************************************************************************")


        var newBuildings: [String] = []
        
        var index = 0
        
        //For other way around
        var index2 = buildings.count
        
        while index < (buildings.count) {
            
            newBuildings[index] = buildings[index2]
            print(index)
            index2 = index2 - 1
            index = index + 1
        }
        
        buildings = newBuildings
        
        //filteredBuildings = buildings
    }
    
   
    @IBAction func nextView(_ sender: Any) {
        if(shortDescription.text != "" && bodyText.text != "")
        {
            next()
            star1.isHidden = true
            star2.isHidden = true
            requiredFields.isHidden = true
        
        }else{
            star1.isHidden = false
            star2.isHidden = false
            requiredFields.isHidden = false

        }
        
    }
    
    func next()
    {
        //Add save data here
        let defaults = UserDefaults.standard
        
        //Servie data tempararaly saved
        defaults.set(shortDescription.text, forKey: "tempShortDescription")
        
        //Servie data tempararaly saved
        defaults.set(bodyText.text, forKey: "tempDescription")
        
        //Servie data tempararaly saved
        defaults.set(building.text, forKey: "tempBuilding")
        
        //Servie data tempararaly saved
        defaults.set(roomNumber.text, forKey: "tempRoomNumber")
        
        //performSegue(withIdentifier: "additional", sender: AnyObject?.self)

    }
    
    
    
    //ADD Gesture Recignizer to Dismiss keyboard then view tapped
    @IBAction func viewTapped(_ sender: AnyObject) {
        bodyText.resignFirstResponder()
        building.resignFirstResponder()
        roomNumber.resignFirstResponder()
        email.resignFirstResponder()
        phoneNumber.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func keyboardWillShow(notification: NSNotification) {
        var translation:CGFloat = 0
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if bodyText.isFirstResponder{
                translation = CGFloat(-keyboardSize.height/5)
            }else if building.isEditing{
                translation = CGFloat(-keyboardSize.height)
            }else if roomNumber.isEditing{
                translation = CGFloat(-keyboardSize.height)
            }
        }
        UIView.animate(withDuration: 0.2) {
            self.view.transform = CGAffineTransform(translationX: 0, y: translation)
        }
    }
    
    func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool // called when   'return' key pressed. return NO to ignore.
    {
        //textField.resignFirstResponder()
        bodyText.resignFirstResponder()
        building.resignFirstResponder()
        roomNumber.resignFirstResponder()
        email.resignFirstResponder()
        phoneNumber.resignFirstResponder()
        
        self.view.endEditing(true)
        
        return true;
    }
    
    func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.2) {
            self.view.transform = CGAffineTransform(translationX: 0, y: 0)
        } 
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "additional" {
            
            let toViewController = segue.destination
            if ((toViewController as? TicketReview ) != nil){
                //NSLog("This is the segue test");
                // toViewController.myData = "Test"
                var cont: TicketReview = toViewController as! TicketReview
                cont.service = service
                cont.category = category
                cont.subCategoryData = subCategoryData
                cont.ounetID = ouNetID2//"OuNET"
                cont.titleOf = shortDescription.text//"HATITLE"
                cont.descriptionOf = bodyText.text//"DESCRIPT"
                
                cont.building = building.text//"THE DEATH STAR"
                cont.roomNumber = roomNumber.text//"1748"
                
                cont.email = email2
                cont.phoneNumber = p
                
                //print("*******************************")
                //print(cont.building)
                //print("*******************************")

                
            }
            
        }
    }
    @IBAction func popUpForBuildings(_ sender: Any) {
        
        if(!popUpIsUP)
        {
            self.view.addSubview(popUpView)
            popUpIsUP = true;
        }else{
            popUpView.removeFromSuperview()
            popUpIsUP = false;
            
            searchBar.text = ""
            searchBar.resignFirstResponder()
            self.locations.reloadData()
            self.filteredBuildings = self.buildings
        
        }
        //popUpIsUP = true;
        
        //popUpView.removeFromSuperview()

        //self.view.addSubview(popUpView)
        
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return self.list.count
        //loadLocationData()
        
        if(searchActive) {
            return filteredBuildings.count
        }
        return self.buildings.count
        //return stack.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:AdditionalInfoTableViewCell = self.locations.dequeueReusableCell(withIdentifier: "LableCell") as UITableViewCell! as! AdditionalInfoTableViewCell
        
        // set the text from the data model
        //cell.lable?.text = self.list[indexPath.row]
        if(searchActive){
            cell.textLabel?.text = filteredBuildings[indexPath.row]
        } else {
            cell.textLabel?.text = buildings[indexPath.row];
        }
        //cell.lable?.text = stack.peek() as! String?
        //printThings();
        //print("THIS IS TEST???")
        //print(self.list.popLast())
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        //subCategoryData = list[indexPath.row];
        building.text = self.filteredBuildings[indexPath.row];
        //subCategoryData = (stack.peek() as! String?)!
        //print("THIS IS TEST???")
        //print(self.list.popLast())
        
        //Gets rid of the table
        popUpView.removeFromSuperview()
        popUpIsUP = false;
        searchBar.text = ""
        searchBar.resignFirstResponder()
        self.locations.reloadData()
        self.filteredBuildings = self.buildings
        
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
        //print("**************************** *********** ******** ***** ***** *** ****")
        //print("Began Editing")
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredBuildings = buildings.filter{$0.contains(searchText) }
        if(filteredBuildings.count == 0){
            searchActive = false;
            filteredBuildings = buildings
        } else {
            searchActive = true;
            filteredBuildings = buildings.filter{$0.contains(searchText) }
        }
        self.locations.reloadData()
    }
    
    func valueChanged(segmentedControl: UISegmentedControl) {
        
        self.locations.reloadData()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField){
        activeField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
        activeField = nil
    }
    
    func loadLocationData()
    {
        let string = "https://servicesapps.ou.edu/chers/mobileapp/Sources/buildings.php"
        Alamofire.request(string, method: .get, encoding: JSONEncoding.default)
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
                        var array = json.arrayValue
                        
                        let numberOfElements = array.count
                        
                        var i = 0
                        while(i < numberOfElements)
                        {
                            let v = array.popLast()!;
                            
                            let vString = v.string!
                            //print(v)
                            self.buildings.append(vString as! String)
                            print("vString: ")
                            print(vString)
                            i+=1
                        }
                        
                        self.buildings.reverse()
                        
                        //print("TestTest")
                        //print(self.buildings)
                        //print(self.list)
                        
                        //print("******************FILTERED BUILDINGS********************")
                        //self.buildings = self.buildings.filter{ $0.contains("Evans") }//Filters the info
                        self.filteredBuildings = self.buildings
                        self.locations.reloadData()
                        
                        
                        
                        
                        
                        
                    }

                    
                }
                
        }
        
                    

    }


}
