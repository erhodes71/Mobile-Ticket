//
//  ExpressCheckIn.swift
//  SidebarMenu
//
//  Created by Eric Rhodes on 4/27/17.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import Foundation

import UIKit

class ExpressCheckIn: UIViewController
{

    
    @IBOutlet var menuButton: UIBarButtonItem!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        print("Finished Loading")
        
        
    }



}
