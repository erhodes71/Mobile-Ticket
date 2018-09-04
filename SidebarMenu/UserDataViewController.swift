//
//  UserDataViewController.swift
//  SidebarMenu
//
//  Created by Eric Rhodes on 4/27/17.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import Foundation
import UIKit

class UserDataViewController: UIViewController, UITextFieldDelegate{
    
    
    var name: String!
    var OUNetID: String!
    var phone: String!
    var email: String!
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var phoneField: UITextField!
    @IBOutlet var ounetIDField: UITextField!
    
    
    
    @IBOutlet var star1: UILabel!
    @IBOutlet var star2: UILabel!
    @IBOutlet var errorMessage: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //name = nameField.text
        OUNetID = ounetIDField.text
        phone = phoneField.text
        //email = emailField.text
        
        ounetIDField.delegate = self;
        phoneField.delegate = self;
        
        star1.isHidden = true
        star2.isHidden = true
        errorMessage.isHidden = true
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        let tap = UITapGestureRecognizer(target: self.view, action: Selector("endEditing:"))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)

        
    }
    
    @IBAction func next(_ sender: Any) {
        
        if phoneField.text == "" || ounetIDField.text == ""{
            
            star1.isHidden = false
            star2.isHidden = false
            errorMessage.isHidden = false
            
        }else{
            
            performSegue(withIdentifier: "userData", sender: AnyObject?.self)
            
        }
        
    }
    
    func endEditing()
    {
        phoneField.resignFirstResponder();
        ounetIDField.resignFirstResponder();
    
    }
    
    func keyboardWillShow(notification: NSNotification) {
        var translation:CGFloat = 0
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if phoneField.isFirstResponder{
                //translation = CGFloat(-keyboardSize.height)
            }
            if ounetIDField.isFirstResponder{
                //translation = CGFloat(-keyboardSize.height)
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool // called when   'return' key pressed. return NO to ignore.
    {
        phoneField.resignFirstResponder();
        ounetIDField.resignFirstResponder();
        
        self.view.endEditing(true)
        
        return true;
    }
    
    //Return Phone
    @IBAction func returnPhone(_ sender: Any) {
        phoneField.resignFirstResponder()
    }
    
    //Return OUNetID
    @IBAction func returnOUNetID(_ sender: Any) {
        ounetIDField.resignFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        //Change to the right name of segue*
        if segue.identifier == "userData" {
            
            let toViewController = segue.destination
            //Change to proper class type*
            if ((toViewController as? ComputerTypeViewController ) != nil){
                //Set the appropriate variables to eachother
                
                var cont: ComputerTypeViewController = toViewController as! ComputerTypeViewController
                //cont.name = nameField.text
                //cont.OUNetID = ounetIDField.text
                //cont.phone = phoneField.text
                //cont.email = emailField.text
                
                //Add save data here
                let defaults = UserDefaults.standard
                
                //Servie data tempararaly saved
                defaults.set(ounetIDField.text, forKey: "tempOUNetID")
                
                //Servie data tempararaly saved
                defaults.set(phoneField.text, forKey: "tempPhoneNumber")
                
                
            }
        }
    }
    
    
    
    
    


}
