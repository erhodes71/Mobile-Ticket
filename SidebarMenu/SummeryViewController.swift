//
//  SummeryViewController.swift
//  SidebarMenu
//
//  Created by Eric Rhodes on 3/21/17.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import Foundation


//****THIS CLASS NEEDS TO BE CHAGNED A LITTLE TO FUCNTION****
class SummeryViewController: UIViewController, UITextViewDelegate{
    
    @IBOutlet var bodyText: UITextView!
    
    var service: String!
    var category: String!
    var subCategoryData: String!
    
    @IBOutlet var ouNetID: UITextField!
    @IBOutlet var shortDescription: UITextField!
    
    @IBOutlet var building: UITextField!
    @IBOutlet var roomNumber: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bodyText.delegate = self //Without setting the delegate you won't be able to track UITextView events
    }
    
    func textViewDidChange(_ textView: UITextView) { //Handle the text changes here
        print(textView.text); //the textView parameter is the textView where text was changed
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "additional" {
            
            let toViewController = segue.destination
            if ((toViewController as? StatusViewController ) != nil){
                //NSLog("This is the segue test");
                // toViewController.myData = "Test"
                var cont: StatusViewController = toViewController as! StatusViewController
                cont.service = service
                cont.category = category
                cont.subCategoryData = subCategoryData
                cont.ounetID = ouNetID.text//"OuNET"
                cont.titleOf = shortDescription.text//"HATITLE"
                cont.descriptionOf = bodyText.text//"DESCRIPT"
                cont.building = building.text//"THE DEATH STAR"
                cont.roomNumber = roomNumber.text//"1748"
                
                
                
                
            }
            
        }
    }
    
    
}
