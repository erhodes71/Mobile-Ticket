//
//  HardwareViewController.swift
//  Quick Ticket
//
//  Created by Eric Rhodes on 4/19/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import Foundation

class HardwareViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "HardwareCheckin", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "InitialController") as UIViewController
        
        self.present(controller, animated: false, completion: nil)
        
       /* let targetStoryboardName = "HardwareCheckin"
        let targetStoryboard = UIStoryboard(name: targetStoryboardName, bundle: nil)
        if let targetViewController = targetStoryboard.instantiateInitialViewController() {
            self.navigationController?.pushViewController(targetViewController, animated: true)
        }
         */
        
    }
    
}
