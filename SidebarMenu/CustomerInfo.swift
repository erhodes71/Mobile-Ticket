//
//  CustomerInfo.swift
//  SidebarMenu
//
//  Created by Eric Rhodes on 5/18/17.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import Foundation


class CustomerInfo: UIViewController, UITextViewDelegate{
    
    @IBOutlet var OUNetID: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var phoneNumber: UITextField!
    
    var service: String!
    var category: String!
    var subCategoryData: String!

    @IBOutlet var star1: UILabel!
    @IBOutlet var requiredField: UILabel!

    @IBOutlet var test: UILabel!
    
    @IBOutlet weak var serviceButton: UIButton!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var subCategoryButton: UIButton!
    
    
    @IBOutlet var customerInfoText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Loading data in
        let defaults = UserDefaults.standard
        
        if let tempID = defaults.string(forKey: "tempOUNetID")
        {
            OUNetID.text = tempID
        }

        
        
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
        
        
        let tap = UITapGestureRecognizer(target: self.view, action: Selector("endEditing:"))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        star1.isHidden = true
        requiredField.isHidden = true
        
        test.text = service
        
        
        var serviceCUT = ""
        if service.characters.count > 10{
            //This works for parsing data
            let servIndex = service.index(service.startIndex, offsetBy: 10)
            serviceCUT = service.substring(to: servIndex)
            print("Test")
            print(serviceCUT)
        }else{
            serviceCUT = service
        }
        
        var catCUT = ""
        if category.characters.count > 10{
            //This works for parsing data
            let catIndex = category.index(category.startIndex, offsetBy: 10)
            catCUT = category.substring(to: catIndex)
            print("Test")
            print(catCUT)
        }else{
            catCUT = category
        }
        
        var catSubCUT = ""
        if subCategoryData.characters.count > 10{
            //This works for parsing data
            let catSubIndex = subCategoryData.index(subCategoryData.startIndex, offsetBy: 10)
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
                customerInfoText.isHidden = true
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //Change to the right name of segue*
        if segue.identifier == "customerInfo" {
            
            let toViewController = segue.destination
            //Change to proper class type
            if ((toViewController as? AdditionalInformationViewController ) != nil){
                
                //Set the appropriate variables to eachother
                var cont: AdditionalInformationViewController = toViewController as! AdditionalInformationViewController
                
                
                
                
            }
            
        }
        
        if segue.identifier == "recategory" {
            
            let toViewController = segue.destination
            if ((toViewController as? CategoryViewController ) != nil){
                //NSLog("This is the segue test");
                // toViewController.myData = "Test"
                var cont: CategoryViewController = toViewController as! CategoryViewController
                //cont.service = service
                
                
                
                
            }
            
        }
        
        if segue.identifier == "resubcategory" {
            
            let toViewController = segue.destination
            if ((toViewController as? subCategory ) != nil){
                //NSLog("This is the segue test");
                // toViewController.myData = "Test"
                var cont: subCategory = toViewController as! subCategory
                //cont.service = service
                //cont.categoryData = category
                
                
                
                
            }
            
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool // called when   'return' key pressed. return NO to ignore.
    {
        //textField.resignFirstResponder()
        OUNetID.resignFirstResponder()
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
    
    @IBAction func changeToNextView(_ sender: Any) {
        if(OUNetID.text != "")
        {
            nextView()
            star1.isHidden = true
            requiredField.isHidden = true
        }else{
            star1.isHidden = false
            requiredField.isHidden = false
        }
    }
    
    //Move to next controller
    func nextView()
    {
        
        //Add save data here
        let defaults = UserDefaults.standard
        
        //Servie data tempararaly saved
        defaults.set(OUNetID.text, forKey: "tempOUNetID")
        
        //Servie data tempararaly saved
        defaults.set(email.text, forKey: "tempEmail")
        
        //Servie data tempararaly saved
        defaults.set(phoneNumber.text, forKey: "tempPhoneNumber")

        
        performSegue(withIdentifier: "customerInfo", sender: AnyObject?.self)
        
    }


}
