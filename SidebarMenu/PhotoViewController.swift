//
//  PhotoViewController.swift
//  SidebarMenu
//
//  Created by Simon Ng on 2/2/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate{
    @IBOutlet weak var menuButton:UIBarButtonItem!
    

    @IBOutlet var shortDescription: UITextField!
    @IBOutlet var longDescription: UITextView!
    
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var phoneTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    
    
    
    
    @IBOutlet var allowSwitch: UISwitch!
    

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
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        let tap = UITapGestureRecognizer(target: self.view, action: Selector("endEditing:"))
        tap.cancelsTouchesInView = false
        //self.view.addGestureRecognizer(tap)
        //self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        nameTextField.delegate = self
        phoneTextField.delegate = self
        emailTextField.delegate = self
        
        let defaults = UserDefaults.standard
        
        
        shortDescription.text = defaults.string(forKey: "shortDescription")
        longDescription.text = defaults.string(forKey: "longDescription")
        
        nameTextField.text = defaults.string(forKey: "name")
        phoneTextField.text = defaults.string(forKey: "phone")
        emailTextField.text = defaults.string(forKey: "email")

        
        
        if defaults.string(forKey: "autoFill") != nil
         {
         
            if var name = defaults.string(forKey: "autoFill")
             {
                if(name == "false")
                {
                    allowSwitch.isOn = false
                }else if(name == "true")
                {
                    allowSwitch.isOn = true

                }
             }
        }else{
            allowSwitch.isOn = false
        }
        
        
        //User auth        
        let stringOne = defaults.string(forKey: "auth")
        if(stringOne == "" || stringOne == "0")
        {
            //Send to log in
            performSegue(withIdentifier: "webView", sender: self)
            
        }else if(stringOne == "1"){
            //Do nothing
            
        }
        print("Finished Loading")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func logOutButtonPressed(_ sender: Any) {
        
        
        
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            // ...
        }
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)

    }
    
    /*func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        print("Test");
        self.view.endEditing(true)
    }*/
    
    
    @IBAction func switchButton(_ sender: Any) {
        let defaults = UserDefaults.standard
        
        if(allowSwitch.isOn)
        {
            defaults.set("true", forKey: "autoFill")
        }else{
            defaults.set("false", forKey: "autoFill")
        }
    }
    
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool // called when   'return' key pressed. return NO to ignore.
    {
        shortDescription.resignFirstResponder()
        longDescription.resignFirstResponder()
        nameTextField.resignFirstResponder()
        phoneTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        
        self.view.endEditing(true)
        
        return true;
    }
    
    func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.2) {
            self.view.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
    
    func keyboardWillShow(notification: NSNotification) {
        var translation:CGFloat = 0
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if longDescription.isFirstResponder{
                translation = CGFloat(-keyboardSize.height/2)
            }else if nameTextField.isFirstResponder{
                translation = CGFloat(-keyboardSize.height)
            }else if phoneTextField.isFirstResponder{
                translation = CGFloat(-keyboardSize.height)
            }else if emailTextField.isFirstResponder{
                translation = CGFloat(-keyboardSize.height)
            }
        }
        UIView.animate(withDuration: 0.2) {
            self.view.transform = CGAffineTransform(translationX: 0, y: translation)
        }
    }
    
    //Keyboard return functions
    @IBAction func returnName(_ sender: Any) {
        nameTextField.resignFirstResponder()
    }
    @IBAction func returnPhone(_ sender: Any) {
        phoneTextField.resignFirstResponder()
    }
    @IBAction func returnEmail(_ sender: Any) {
        emailTextField.resignFirstResponder()
    }
    

    
    //Store Data
    @IBAction func addIDPressed(_ sender: Any) {
        let defaults = UserDefaults.standard
        
   
        let shortDes = shortDescription.text
        let longDes = longDescription.text
        
        let name = nameTextField.text;
        let phone = phoneTextField.text;
        let email = emailTextField.text;
        
        // Store
        defaults.set(shortDes, forKey: "shortDescription")
        defaults.set(longDes, forKey: "longDescription")
        
        //defaults.set(name, forKey: "name")
        //defaults.set(phone, forKey: "phone")
        //defaults.set(email, forKey: "email")
        
        var alertView = UIAlertView();
        alertView.addButton(withTitle: "OK");
        alertView.title = "Message";
        alertView.message = "User Information Updated!";
        alertView.show();
        
    }


}
