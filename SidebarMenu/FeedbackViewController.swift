//
//  FeedbackViewController.swift
//  Quick Ticket
//
//  Created by Eric Rhodes on 11/20/17.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import Foundation

class FeedbackViewController: UIViewController , UIWebViewDelegate{
    
    @IBOutlet var webView: UIWebView!
    var indentification  = (String)()
    //var indentification: (NSString)
    
    @IBOutlet var menuButton: UIBarButtonItem!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Loads the address to the webView
        //sleep(12);
        
        let str = String(format: "https://www.surveymonkey.com/r/N6G7F6Q")
        
        let url = NSURL (string: str);
        let requestObj = NSURLRequest(url: url! as URL);
        webView.loadRequest(requestObj as URLRequest);
        
        
        //THIS IS USED FOR THE MENU
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            //self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.revealViewController().tapGestureRecognizer()
            self.revealViewController().panGestureRecognizer()
            
            
        }
        
        /*if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                print("iPhone 5 or 5S or 5C")
            case 1334:
                print("iPhone 6/6S/7/8")
            case 2208:
                print("iPhone 6+/6S+/7+/8+")
            case 2436:
                print("iPhone X")
            default:
                print("unknown")
            }
        }*/
        
        
        self.view.isUserInteractionEnabled = true;
        self.webView.isUserInteractionEnabled = true;
        
        
    }
}
