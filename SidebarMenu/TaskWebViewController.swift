//
//  TaskWebViewController.swift
//  Alamofire iOS
//
//  Created by Eric Rhodes on 11/2/17.
//  Copyright © 2017 Alamofire. All rights reserved.
//

import Foundation
class TaskWebViewController: UIViewController , UIWebViewDelegate{
    
    
    @IBOutlet var webView: UIWebView!
    var indentification  = (String)()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Loads the address to the webView
        
        let str = String(format: "http://ou.cherwellondemand.com/Cherwellclient/samllogin/Access/Command/Queries.GotoRecord?BusObId=9355d5ed41e384ff345b014b6cb1c6e748594aea5b&RecId=%@", indentification)
        
        let url = NSURL (string: str);
        let requestObj = NSURLRequest(url: url! as URL);
        webView.loadRequest(requestObj as URLRequest);
        
        self.view.isUserInteractionEnabled = true;
        self.webView.isUserInteractionEnabled = true;
        
        
    }
    
}
