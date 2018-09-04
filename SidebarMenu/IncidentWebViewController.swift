//
//  IncidentWebViewController.swift
//  Quick Ticket
//
//  Created by Eric Rhodes on 11/1/17.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import Foundation

class IncidentWebViewController: UIViewController , UIWebViewDelegate{

    @IBOutlet var webView: UIWebView!
    var indentification  = (String)()
    //var indentification: (NSString)
    
    //var url: (NSString)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Loads the address to the webView
        
        let str = String(format: "http://ou.cherwellondemand.com/Cherwellclient/samllogin/Access/Command/Queries.GotoRecord?BusObId=6dd53665c0c24cab86870a21cf6434ae&RecId=%@", indentification)
        
        let url = NSURL (string: str);
        let requestObj = NSURLRequest(url: url! as URL);
        webView.loadRequest(requestObj as URLRequest);
        
        self.view.isUserInteractionEnabled = true;
        self.webView.isUserInteractionEnabled = true;
        
        
    }
}

