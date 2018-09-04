//
//  ShortCustomerInfoViewController.swift
//  SidebarMenu
//
//  Created by Eric Rhodes on 5/30/17.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import Foundation


class ShortCustomerInfoViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate
{
    
    var service: String!
    var category: String!
    var subCategoryData: String!
    
    @IBOutlet var ounetID: UITextField!
    @IBOutlet var shortDescription: UITextField!
    
    @IBOutlet weak var star1: UILabel!
    @IBOutlet weak var star2: UILabel!
    @IBOutlet weak var reqiuredFieldLable: UILabel!
    
    @IBOutlet weak var serviceButton: UIButton!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var subCategoryButton: UIButton!
    
    
    @IBOutlet var customerInfoText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ounetID.delegate = self
        shortDescription.delegate = self
        
        star1.isHidden = true;
        star2.isHidden = true;
        reqiuredFieldLable.isHidden = true;
        
        //Loading data in
        let defaults = UserDefaults.standard
        
        if let serv = defaults.string(forKey: "tempService")
        {
            service = serv
        }
        
        if let catt = defaults.string(forKey: "tempCategory")
        {
            category = catt
        }
        
        if let subb = defaults.string(forKey: "tempSub")
        {
            subCategoryData = subb
        }
        
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
        
        
        //serviceButton
        serviceButton.setTitle(serviceCUT, for: UIControlState.normal)
        
        //categoryButton
        categoryButton.setTitle(catCUT, for: UIControlState.normal)
        
        //categoryButton
        subCategoryButton.setTitle(catSubCUT, for: UIControlState.normal)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: NSNotification.Name.UIKeyboardWillHide, object: nil)

        
        let tap = UITapGestureRecognizer(target: self.view, action: Selector("endEditing:"))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        
        
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
        
    }
    
    @IBAction func returnedOUNetIDTest(_ sender: Any) {
        //print("Test")
        ounetID.resignFirstResponder()
    }
    
    @IBAction func returnedShortDescriptionTest(_ sender: Any) {
        shortDescription.resignFirstResponder()
    }
    
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //Change to the right name of segue*
        if segue.identifier == "customerInfo" {
            
            let toViewController = segue.destination
            //Change to proper class type
            if ((toViewController as? ShortSubmitViewController ) != nil){
                //Set the appropriate variables to eachother
                var cont: ShortSubmitViewController = toViewController as! ShortSubmitViewController
                //cont.service = service
                //cont.category = category
                //cont.subCategoryData = subCategoryData

                //cont.ouNetID = ounetID.text
                //cont.shortDescription = shortDescription.text
                
                
            }
            
        }
        
        if segue.identifier == "recategory2" {
            
            let toViewController = segue.destination
            if ((toViewController as? CategoryViewController ) != nil){
                //NSLog("This is the segue test");
                // toViewController.myData = "Test"
                let cont: CategoryViewController = toViewController as! CategoryViewController
                //cont.service = service
                
                
                
                
            }
            
        }
        
        if segue.identifier == "resubcategory" {
            
            let toViewController = segue.destination
            if ((toViewController as? subCategory ) != nil){
                //NSLog("This is the segue test");
                // toViewController.myData = "Test"
                let cont: subCategory = toViewController as! subCategory
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
        NSLog("TEST");
        //textField.resignFirstResponder()
        ounetID.resignFirstResponder()
        shortDescription.resignFirstResponder()
        
        self.view.endEditing(true)
        
        return true;
    }
    
    @IBAction func textField(_ sender: AnyObject) {
        self.view.endEditing(true);
    }
    
    func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.2) {
            self.view.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
    
    func keyboardWillShow(notification: NSNotification) {
        var translation:CGFloat = 0
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if ounetID.isFirstResponder{
                print("OUNETID-------------->")
                translation = CGFloat(-keyboardSize.height/2)
            }else if shortDescription.isEditing{
                print("shortDescription-------------->")
                translation = CGFloat(-keyboardSize.height/2)
            }
        }
        UIView.animate(withDuration: 0.2) {
            self.view.transform = CGAffineTransform(translationX: 0, y: translation)
        }
    }
    
    
    
    
    
    @IBAction func category(_ sender: Any) {
        
        //performSegue(withIdentifier: "recategory", sender: AnyObject?.self)

    }

    
    @IBAction func nextPage(_ sender: Any) {
        if(ounetID.text != "" || shortDescription.text != "")
        {
            star1.isHidden = true;
            star2.isHidden = true;
            reqiuredFieldLable.isHidden = true;
            nextView()
        
        }else{
        
            star1.isHidden = false;
            star2.isHidden = false;
            reqiuredFieldLable.isHidden = false;

        }
        
    }
    
    //Move to next controller
    func nextView()
    {
        //Add save data here
        let defaults = UserDefaults.standard
        
        //Servie data tempararaly saved
        defaults.set(ounetID.text, forKey: "tempOUNetID")
        
        //Servie data tempararaly saved
        defaults.set(shortDescription.text, forKey: "tempShortDescription")
        
        performSegue(withIdentifier: "customerInfo", sender: AnyObject?.self)
        
    }
    

}
