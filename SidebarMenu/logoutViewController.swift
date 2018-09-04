//
//  logoutViewController.swift
//  Quick Ticket
//
//  Created by Eric Rhodes on 11/10/17.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import Foundation
import UIKit

class logoutViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate{
    
    @IBOutlet var webView: UIWebView!
    
    @IBOutlet var loadScreen: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.isUserInteractionEnabled = true;
        
        let str = String(format: "https://sso.ou.edu/ext/logmeout")
        
        let url = NSURL (string: str);
        let requestObj = NSURLRequest(url: url! as URL);
        webView.loadRequest(requestObj as URLRequest);
        
        self.view.isUserInteractionEnabled = true;
        self.webView.isUserInteractionEnabled = true;
        
        loadScreen.isHidden = false
        
        
        let defaults = UserDefaults.standard
        
        
        
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        if webView.isLoading{
            return
        }
        print("Done loading")
        
        //Loads defualts
        let defaults = UserDefaults.standard
        
        var firstName = "";
        var lastName = "";
        var ouNetId = "";
        
        if let text = webView.request?.url?.absoluteString{
            print(text)
            
            //loadScreen.isHidden = false
            
            if(text == "https://itnews.ou.edu/single-sign-on/")
            {
                
                print("Made it")
                
                //Sets the auth to true
                defaults.set("0", forKey: "auth")
                defaults.set("", forKey: "username")
                defaults.set("", forKey: "name")
                
                let storage = HTTPCookieStorage.shared
                for cookie in storage.cookies! {
                    storage.deleteCookie(cookie)
                }
                
                
                //Re-direct them to the alerts screen
                _ = navigationController?.popViewController(animated: true)
            }
        }
        
    }
}
