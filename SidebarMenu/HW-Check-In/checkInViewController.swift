//
//  checkInViewController.swift
//  Quick Ticket
//
//  Created by Eric Rhodes on 4/18/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import Foundation

class checkInViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    @IBOutlet var pickerView: UIPickerView!
    
    
    @IBOutlet var checkInLocationLabel: UILabel!
    @IBOutlet var checkInShelfLabel: UILabel!
    @IBOutlet var currentLocationLabel: UILabel!
    @IBOutlet var currentShelfLabel: UILabel!
    
    @IBOutlet var transferLocationLabel: UILabel!
    
    
    
    
    
    var list = [""]
    let locations = ["Bizzell Edge","EL 201","Kuhlman(Abandoned)","Kuhlman(Hardware)","OneU"]
    let bizShelfs = ["B-L01","B-L02","B-L03","B-L04","B-L05","B-L06"]
    var elShelfs = ["E-D01","E-D02","E-D03","E-D04","E-D05"]
    let kuhlmanAbandondedShelfs = ["A-D04","A-D05","A-L01","A-L02","A-L03"]
    var kuhlmanHardwareShelfs = ["H-D25","H-D26","H-D27","H-D28","H-D29","H-D30"]
    var oneuShelfts = ["O-01"]
    
    var checkinLocation: String!
    var checkinShelf: String!
    var currentLocation: String!
    var currentShelf: String!
    var transferLocation: String!
    
    var checkinLocationIsSelected: Bool!
    var checkinShelfIsSelected: Bool!
    var currentLocationIsSelected: Bool!
    var currentShelfIsSelected: Bool!
    var transferLocationIsSelected: Bool!
    
    var value: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkinLocation = ""
        checkinShelf = ""
        currentLocation = ""
        currentShelf = ""
        transferLocation = ""
        
        checkinLocationIsSelected = false
        checkinShelfIsSelected = false
        currentLocationIsSelected = false
        currentShelfIsSelected = false
        transferLocationIsSelected = false
        
        checkInLocationLabel.text = ""
        checkInShelfLabel.text = ""
        currentLocationLabel.text = ""
        currentShelfLabel.text = ""
        transferLocationLabel.text = ""
        
        
        for i in 1 ... 36 {
            
            var s = "E-L0" + String(i)
            elShelfs.append(s)
            
        }
        
        for i in 1 ... 24 {
            
            var s = "H-L0" + String(i)
            kuhlmanHardwareShelfs.append(s)
            
        }
        
        for i in 2 ... 33 {
            
            var s = "O-0" + String(i)
            oneuShelfts.append(s)
            
        }
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        pickerView.isHidden = true
        
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return list[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if(checkinLocationIsSelected){
            checkinLocation = list[row]
            checkInLocationLabel.text = checkinLocation
            checkInShelfLabel.text = ""
        }else if(checkinShelfIsSelected){
            checkinShelf = list[row]
            checkInShelfLabel.text = checkinShelf
        }else if(currentLocationIsSelected){
            currentLocation = list[row]
            currentLocationLabel.text = currentLocation
            currentShelfLabel.text = ""
        }else if(currentShelfIsSelected){
            currentShelf = list[row]
            currentShelfLabel.text = currentShelf
        }else if(transferLocationIsSelected){
            transferLocation = list[row]
            transferLocationLabel.text = transferLocation
        }
        
        //value = list[row]
        //pickerView.isHidden = true
    }
    
    
    
    //Buttons being pressed
    @IBAction func checkInLocationButtonPressed(_ sender: Any) {
        
        checkinLocationIsSelected = true
        checkinShelfIsSelected = false
        currentLocationIsSelected = false
        currentShelfIsSelected = false
        transferLocationIsSelected = false
        
        list  = locations
        pickerView.reloadAllComponents()
        pickerView.isHidden = false
    }
    @IBAction func checkInShelfButtonPressed(_ sender: Any) {
        
        checkinLocationIsSelected = false
        checkinShelfIsSelected = true
        currentLocationIsSelected = false
        currentShelfIsSelected = false
        transferLocationIsSelected = false
        
        if (checkinLocation == "Bizzell Edge"){
            list = bizShelfs
        }else if(checkinLocation == "EL 201"){
            list = elShelfs
        }else if(checkinLocation == "Kuhlman(Abandoned)"){
            list = kuhlmanAbandondedShelfs
        }else if(checkinLocation == "Kuhlman(Hardware)"){
            list = kuhlmanHardwareShelfs
        }else if(checkinLocation == "OneU"){
            list = oneuShelfts
        }
        
        pickerView.reloadAllComponents()
        pickerView.isHidden = false
    }
    @IBAction func currentLocationButtonPressed(_ sender: Any) {
        
        checkinLocationIsSelected = false
        checkinShelfIsSelected = false
        currentLocationIsSelected = true
        currentShelfIsSelected = false
        transferLocationIsSelected = false
        
        list  = locations
        pickerView.reloadAllComponents()
        pickerView.isHidden = false
    }
    @IBAction func currentShelfButtonPressed(_ sender: Any) {
        
        checkinLocationIsSelected = false
        checkinShelfIsSelected = false
        currentLocationIsSelected = false
        currentShelfIsSelected = true
        transferLocationIsSelected = false
        
        if (currentLocation == "Bizzell Edge"){
            list = bizShelfs
        }else if(currentLocation == "EL 201"){
            list = elShelfs
        }else if(currentLocation == "Kuhlman(Abandoned)"){
            list = kuhlmanAbandondedShelfs
        }else if(currentLocation == "Kuhlman(Hardware)"){
            list = kuhlmanHardwareShelfs
        }else if(currentLocation == "OneU"){
            list = oneuShelfts
        }
        
        //list  = locations
        pickerView.reloadAllComponents()
        pickerView.isHidden = false
    }
    @IBAction func transferToLocationButtonPressed(_ sender: Any) {
        checkinLocationIsSelected = false
        checkinShelfIsSelected = false
        currentLocationIsSelected = false
        currentShelfIsSelected = false
        transferLocationIsSelected = true
        
        list  = locations
        pickerView.reloadAllComponents()
        pickerView.isHidden = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        pickerView.isHidden = true
    }
    
    //Updates the data for different selections
    func updateData(key: String, value: String)
    {
        //Add save data here
        let defaults = UserDefaults.standard
        
        //data tempararaly saved
        defaults.set(value, forKey: key)
        
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        updateData(key: "tempCheckInLocation", value: checkinLocation)
        updateData(key: "tempCheckInShelf", value: checkinShelf)
        updateData(key: "tempCurrentLocation", value: currentLocation)
        updateData(key: "tempCurrentShelf", value: currentShelf)
        updateData(key: "tempTransferLocation", value: transferLocation)
    }
    
    
    
    
    
    
}
