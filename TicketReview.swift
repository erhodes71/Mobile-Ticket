//
//  TicketReview.swift
//  SidebarMenu
//
//  Created by Eric Rhodes on 3/27/17.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import Foundation


class TicketReview: UIViewController, UITextViewDelegate{

    var service: String!
    var category: String!
    var subCategoryData: String!
    
    var ounetID: String!
    var titleOf: String!
    var descriptionOf: String!
    var building: String!
    var roomNumber: String!
    
    var email: String!
    var phoneNumber: String!
    
    
    
    
    
    //UI Items
    @IBOutlet var nameLable: UILabel!
    @IBOutlet var alternatePhoneLable: UILabel!
    @IBOutlet var alternateEmailLable: UILabel!
    @IBOutlet var titleLable: UILabel!
    
    @IBOutlet var descriptionLable: UITextView!
    
    
    
    @IBOutlet weak var serviceButton: UIButton!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var subCategoryButton: UIButton!
    
    
    @IBOutlet var ticketReviewText: UILabel!
    
    
    
    
    
    
    
    
    
    
    //VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Loading data in
        let defaults = UserDefaults.standard
        
        
        
        
        
        if let OUNetID = defaults.string(forKey: "tempOUNetID")
        {
            nameLable.text = OUNetID
        }
        
        if let phoneNumber = defaults.string(forKey: "tempPhoneNumber")
        {
            alternatePhoneLable.text = phoneNumber
        }
        
        if let emailNumber = defaults.string(forKey: "tempEmail")
        {
            alternateEmailLable.text = emailNumber
        }
        
        if let shortDescription = defaults.string(forKey: "tempShortDescription")
        {
            titleLable.text = shortDescription
        }
        
        if let descript = defaults.string(forKey: "tempDescription")
        {
            descriptionLable.text = descript
        }
        
        //let defaults = UserDefaults.standard
        
        
        if let serv = defaults.string(forKey: "tempService")
        {
            service = serv
        }
        
        if let catt = defaults.string(forKey: "tempCategory")
        {
            category = catt
        }
        
        if let subCatt = defaults.string(forKey: "tempSub")
        {
            subCategoryData = subCatt
        }
        
        
        
        var serviceCUT = ""
        if service.characters.count > 5{
            //This works for parsing data
            let servIndex = service.index(service.startIndex, offsetBy: 5)
            serviceCUT = service.substring(to: servIndex)
            print("Test")
            print(serviceCUT)
        }else{
            serviceCUT = service
        }
        
        var catCUT = ""
        if category.characters.count > 5{
            //This works for parsing data
            let catIndex = category.index(category.startIndex, offsetBy: 5)
            catCUT = category.substring(to: catIndex)
            print("Test")
            print(catCUT)
        }else{
            catCUT = category
        }
        
        var catSubCUT = ""
        if subCategoryData.characters.count > 5{
            //This works for parsing data
            let catSubIndex = subCategoryData.index(subCategoryData.startIndex, offsetBy: 5)
            catSubCUT = subCategoryData.substring(to: catSubIndex)
            print("Test")
            print(catSubCUT)
        }else{
            catSubCUT = subCategoryData
        }
        
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                print("iPhone 5 or 5S or 5C")
            case 1334:
                print("iPhone 6/6S/7/8")
            case 2208:
                print("iPhone 6+/6S+/7+/8+")
            case 2436:
                print("iPhone X")
                ticketReviewText.isHidden = true
            default:
                print("unknown")
            }
        }
        
        
        //serviceButton
        serviceButton.setTitle(serviceCUT, for: UIControlState.normal)
        
        //categoryButton
        categoryButton.setTitle(catCUT, for: UIControlState.normal)
        
        //categoryButton
        subCategoryButton.setTitle(catSubCUT, for: UIControlState.normal)
        
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ticketReview" {
            
            let toViewController = segue.destination
            if ((toViewController as? SubmitTicketViewController ) != nil){
                //NSLog("This is the segue test");
                // toViewController.myData = "Test"
                var cont: SubmitTicketViewController = toViewController as! SubmitTicketViewController
                
                
                
                
            }
            
        }
    }
    
    
    


}
