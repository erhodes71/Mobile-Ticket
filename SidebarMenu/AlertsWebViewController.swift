//
//  AlertsWebViewController.swift
//  Quick Ticket
//
//  Created by Eric Rhodes on 11/3/17.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import Foundation

class AlertsWebViewController: UIViewController, UIWebViewDelegate{
    
    @IBOutlet var webView: UIWebView!
    
    @IBOutlet var loadScreen: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Loads the address to the webView
        
        
        let str = String(format: "http://sso.ou.edu/idp/startSSO.ping?PartnerSpId=quickticket")
        
        let url = NSURL (string: str);
        let requestObj = NSURLRequest(url: url! as URL);
        webView.loadRequest(requestObj as URLRequest);
        
        self.view.isUserInteractionEnabled = true;
        self.webView.isUserInteractionEnabled = true;
        
        loadScreen.isHidden = true
       
        
        let defaults = UserDefaults.standard
        
        //Sets auth back to 1
        //defaults.set("1", forKey: "auth")
        
        //Brings back to alerts screen
        //_ = navigationController?.popViewController(animated: true)
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
            if(!(text == "https://sso.ou.edu/idp/startSSO.ping?PartnerSpId=quickticket"))
            {
                loadScreen.isHidden = false
            }
            
            if(text == "https://servicesapps.ou.edu/mobileapp/")
            {
                
                print("Made it")
                
                //Sets the auth to true
                defaults.set("1", forKey: "auth")
                
                //Get cookie data and save it
                if let cookies = HTTPCookieStorage.shared.cookies {
                    for cookie in cookies {
                        //NSLog("\(cookie)")
                        
                        if( cookie.name == "FirstName")
                        {
                            print(cookie.value)
                            //defaults.set("1", forKey: "auth")
                            firstName = cookie.value;
                            
                        }
                        if( cookie.name == "LastName")
                        {
                            print(cookie.value)
                            //defaults.set("1", forKey: "auth")
                            lastName = cookie.value;
                            
                        }
                        if( cookie.name == "OuNetId")
                        {
                            print(cookie.value)
                            //defaults.set("1", forKey: "auth")
                            ouNetId = cookie.value;
                            
                        }
                    }
                    
                    defaults.set(ouNetId, forKey: "username");
                    defaults.set(firstName + " " + lastName, forKey: "name");
                }
                
                
                //Re-direct them to the alerts screen
                _ = navigationController?.popViewController(animated: true)
            }
        }
       
    }
    
    
    
}
