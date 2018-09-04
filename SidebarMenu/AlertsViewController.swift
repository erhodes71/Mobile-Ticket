//
//  AlertsViewController.swift
//  SidebarMenu
//
//  Created by Eric Rhodes on 5/2/17.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import Foundation


class AlertsViewController: UIViewController , UIWebViewDelegate{
    
    
    @IBOutlet weak var menuButton:UIBarButtonItem!
    @IBOutlet var webView: UIWebView!
    
    var url: NSURL!
    
    @IBOutlet var tapButton: UIButton!
    
    @IBOutlet var activitIndicator: UIActivityIndicatorView!
    
    var isPoppedOut: Bool!
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Do any additional setup after loading the view.
        //webView.scalesPageToFit = true
        
        self.view.isUserInteractionEnabled = true;
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            //self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            //self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
            self.revealViewController().tapGestureRecognizer()
            self.revealViewController().panGestureRecognizer()

            isPoppedOut = false;
            
            //url = NSURL (string: "http://alerts.ou.edu");
            let requestObj = NSURLRequest(url: url! as URL);
            webView.loadRequest(requestObj as URLRequest);
            
            self.activitIndicator.hidesWhenStopped = true

        }
    }

    
    
    @IBAction func menuButtonPressed(_ sender: Any) {
        
        print("menu button pressed")
        if(!isPoppedOut)
        {
            isPoppedOut = true;
            print("true")
            tapButton.isHidden = true;
            webView.isHidden = true;
        }else{
            
            isPoppedOut = false;
            print("false")
            tapButton.isHidden = false;
            webView.isHidden = false;
        }
        
    }
    
    
    
    
    @IBAction func tapButton(_ sender: Any)
    {
        print("TestTest");
        
        
    }
    
    func testMethod()
    {
        print("Also Test")
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Loads the address to the webView
        //sleep(12);
        //print("#############################")
        
        //User auth
        let defaults = UserDefaults.standard

        /*let stringOne = defaults.string(forKey: "auth")
        if(stringOne == "" || stringOne == "0")
        {
            //Send to log in
            performSegue(withIdentifier: "webView", sender: self)
            
        }else if(stringOne == "1"){
            //Do nothing
            
        }*/
        
        
        
        url = NSURL (string: "http://alerts.ou.edu");
        //let requestObj = NSURLRequest(url: url! as URL);
        //webView.loadRequest(requestObj as URLRequest);
        
        self.view.isUserInteractionEnabled = true;
        self.webView.isUserInteractionEnabled = true;
        
        self.revealViewController().tapGestureRecognizer()
        self.revealViewController().panGestureRecognizer()
        
        //Loads defaults
        //let defaults = UserDefaults.standard
        let firstTime = defaults.string(forKey: "firstTime")
        print(firstTime)
        if(firstTime != "True")
        {
            defaults.set("True", forKey: "firstTime")
            let alert = UIAlertController(title: "Welcome to the OUIT Quick Ticket App!", message: "Please fill out the User Info Page before making any tickets!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Sure!", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        //Sets auth back to 0
        //defaults.set("0", forKey: "auth")
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Test");
        
    }
    
   
    
    
    override func viewDidAppear(_ animated: Bool) {
        activitIndicator.startAnimating()

    }
    
    func webViewDidFinishLoad(_ webView: UIWebView)
    {
        
        print("#############################")
        
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
        
        
        //Sets auth back to 0
        //defaults.set("0", forKey: "auth")
        
        activitIndicator.stopAnimating()
    }
    
    
    
    
}
