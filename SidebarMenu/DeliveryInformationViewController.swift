//
//  DeliveryInformationViewController.swift
//  SidebarMenu
//
//  Created by Eric Rhodes on 4/27/17.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import Foundation
import UIKit
import Alamofire


class DeliveryInformationTableViewCell: UITableViewCell
{

    @IBOutlet var lable: UILabel!
    
}


class DeliveryInformationViewController: UIViewController, UITextViewDelegate, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    
    //User Data
    var name: String!
    var OUNetID: String!
    var phone: String!
    var email: String!
    
    //Computer Type
    var computerType: String!
    
    //Computer Make
    var computerMake: String!
    
    //Data Backup
    var dataBackup: String!
    
    //Delivery Information
    var deliveryInformation: String!
    
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
    
    
    //Required Fields
    @IBOutlet var star1: UILabel!
    @IBOutlet var star2: UILabel!
    @IBOutlet var star3: UILabel!
    @IBOutlet var star4: UILabel!
    @IBOutlet var star5: UILabel!
    @IBOutlet var star6: UILabel!
    @IBOutlet var errormessage: UILabel!
    
    
    
    
    var pLocation: Bool = false;//If the pickup location is selected
    var dLocation: Bool = false;//If the Delivery location is selected
    
    @IBOutlet var popUpView: UIView!
    @IBOutlet var locations: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    
    @IBOutlet var serialNumberEnter: UITextField!
    @IBOutlet var pickUpLocation: UITextField!
    @IBOutlet var pickupRoomEnter: UITextField!
    @IBOutlet var deliveryLocation: UITextField!
    @IBOutlet var deliveryRoomEnter: UITextField!
    
    @IBOutlet var descriptionEnter: UITextView!
    
    
    
    
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"
    
    
    //Buildings list
    var buildings: [String] = []
    var searchActive : Bool = false
    var filteredBuildings: [String] = []
    
    var keyBoardIsUp: Bool = false;
    
    var popUpIsUP : Bool = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadLocationData()
        
        
        
        
        // Register the table view cell class and its reuse id
        self.locations.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        
        locations.delegate = self
        locations.dataSource = self
        searchBar.delegate = self
        
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
        
        //Required Fields
        star1.isHidden = true
        star2.isHidden = true
        star3.isHidden = true
        star4.isHidden = true
        star5.isHidden = true
        star6.isHidden = true
        errormessage.isHidden = true
        
 
    }
    
    @IBAction func next(_ sender: Any) {
        
        if serialNumberEnter.text == "" || pickUpLocation.text == "" || pickupRoomEnter.text == "" || deliveryLocation.text == "" || deliveryRoomEnter.text == "" || descriptionEnter.text == ""{
        
            star1.isHidden = false
            star2.isHidden = false
            star3.isHidden = false
            star4.isHidden = false
            star5.isHidden = false
            star6.isHidden = false
            errormessage.isHidden = false
        
        }else{
        
        //Add save data here
        let defaults = UserDefaults.standard
        
        //Servie data tempararaly saved
        defaults.set(serialNumberEnter.text, forKey: "tempSerialNumber")
        
        defaults.set(pickUpLocation.text, forKey: "tempPickupLocation")
        
        defaults.set(pickupRoomEnter.text, forKey: "tempPickupRoom")
        
        defaults.set(deliveryLocation.text, forKey: "tempDeliveryLocation")
        
        defaults.set(deliveryRoomEnter.text, forKey: "tempDeliveryRoom")
        
        defaults.set(descriptionEnter.text, forKey: "tempDescription")
        
        
        
        performSegue(withIdentifier: "deliveryInformation", sender: AnyObject?.self)
        
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "deliveryInformation" {
            
            let toViewController = segue.destination
            if ((toViewController as? TicketReview ) != nil){
                
                
                var cont: expressTicketReview = toViewController as! expressTicketReview
                
                
            }
            
        }
    }
    
    
    //Handles Keyboard
    @IBAction func returnSerialNumber(_ sender: Any) {
        serialNumberEnter.resignFirstResponder()
    }
    @IBAction func returnPickupLocation(_ sender: Any) {
        pickUpLocation.resignFirstResponder()
    }
    @IBAction func returnPickupRoom(_ sender: Any) {
        pickupRoomEnter.resignFirstResponder()
    }
    @IBAction func returnDeliveryLocation(_ sender: Any) {
        deliveryLocation.resignFirstResponder()
    }
    @IBAction func returnDeliveryRoom(_ sender: Any) {
        deliveryRoomEnter.resignFirstResponder()
    }
    
    
    
    
    
    
    
    func keyboardWillShow(notification: NSNotification) {
        var translation:CGFloat = 0
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if descriptionEnter.isFirstResponder{
                translation = CGFloat(-keyboardSize.height)
            }
            
        }
        UIView.animate(withDuration: 0.2) {
            self.view.transform = CGAffineTransform(translationX: 0, y: translation)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.2) {
            self.view.transform = CGAffineTransform(translationX: 0, y: 0)
        }
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

    
    func reverseBuildingList()
    {
        
        
        
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
    
    func textFieldDidBeginEditing(_ textField: UITextField){
        print("Test")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
        print("Test2")

    }
    @IBAction func popUpForBuildings(_ sender: Any) {
        
        if(!popUpIsUP)
        {
            self.view.addSubview(popUpView)
            popUpIsUP = true;
            searchBar.text = ""
            self.locations.reloadData()
            
            pLocation = true;
            dLocation = false;
        }else{
            popUpView.removeFromSuperview()
            popUpIsUP = false;
            searchBar.text = ""
            searchBar.resignFirstResponder()
            self.locations.reloadData()
            self.filteredBuildings = self.buildings
            
            pLocation = false;
            dLocation = false;
            
        }
        //pLocation = true;
        //dLocation = false;
    }
    
    @IBAction func popUpForBuildingsDelivery(_ sender: Any) {
        
        if(!popUpIsUP)
        {
            self.view.addSubview(popUpView)
            popUpIsUP = true;
            searchBar.text = ""
            self.locations.reloadData()
            
            dLocation = true;
            pLocation = false;
        }else{
            popUpView.removeFromSuperview()
            popUpIsUP = false;
            searchBar.text = ""
            searchBar.resignFirstResponder()
            self.locations.reloadData()
            self.filteredBuildings = self.buildings

            
            
            dLocation = false;
            pLocation = false;
            
        }
        //dLocation = true;
        //pLocation = false;
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    
    func textFieldShouldReturn(textField: UITextField!) -> Bool // called when   'return' key pressed. return NO to ignore.
    {
        //textField.resignFirstResponder()
        print("textFieldReturn")
        
        self.view.endEditing(true)
        
        return true;
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if(searchActive) {
            return filteredBuildings.count
        }
        return self.buildings.count
        //return stack.count
    }
    
   
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:DeliveryInformationTableViewCell = self.locations.dequeueReusableCell(withIdentifier: "LableCell") as UITableViewCell! as! DeliveryInformationTableViewCell
        
    
        if(searchActive){
            cell.textLabel?.text = filteredBuildings[indexPath.row]
        } else {
            cell.textLabel?.text = buildings[indexPath.row];
        }
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        if(pLocation)
        {
            pickUpLocation.text = filteredBuildings[indexPath.row];
        }else if(dLocation){
            deliveryLocation.text = filteredBuildings[indexPath.row];
        }
        
        popUpView.removeFromSuperview()
        popUpIsUP = false;
        
        pLocation = false;
        dLocation = false;
        self.filteredBuildings = self.buildings
        
        //building.text = self.filteredBuildings[indexPath.row];
        
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
                        
                    
                        self.filteredBuildings = self.buildings
                        self.locations.reloadData()
                        
                        
                        
                        
                        
                        
                    }
                    
                    
                }
                
        }

    
    }
    
    
}
