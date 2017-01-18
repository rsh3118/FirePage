//
//  Page.swift
//  FirePage
//
//  Created by The Ritler on 12/28/16.
//  Copyright © 2016 The Ritler. All rights reserved.


import Foundation
import UIKit
import Firebase

class Page: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    var location = String()
    var selected: String {
        return UserDefaults.standard.string(forKey: "selected") ?? ""
    }
    let master = UIApplication.shared.delegate as! AppDelegate
    let pageRef = FIRDatabase.database().reference().child("pages").child("Ritwik")
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("loo")
        textField.resignFirstResponder()
        return true;
    }
    var date = NSDate()
    var calendar = NSCalendar.current
    var month = 1
    var year = 1
    var day = 1
    var hour = 1
    var minute = 1
    var second = 1
    var pageStatusButton = UIButton(frame: CGRect(x: 300, y: 300, width: 300, height: 50))
    var sendAnotherPage = UIButton(frame: CGRect(x: 300, y: 300, width: 300, height: 50))
    var locationPicker: UIPickerView = UIPickerView(frame: CGRect(x: 20, y: 100, width: 300, height: 100))
    var descriptionField = UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
    var locationField = UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
    
    let dormlist : [String] = ["Blackwell", "Randolph", "Bell Tower", "Epworth", "East House", "Wilson", "Brown", "Bassett", "GA", "Southgate"]
    func DFrame (oldFrame: CGRect) -> CGRect {
        let newX = Int((Float(oldFrame.minX)/414.0)*Float(UIScreen.main.bounds.width))
        let newY = Int((Float(oldFrame.minY)/736.0)*Float(UIScreen.main.bounds.height))
        let newW = Int((Float(oldFrame.width)/414.0)*Float(UIScreen.main.bounds.width))
        let newH = Int((Float(oldFrame.height)/736.0)*Float(UIScreen.main.bounds.height))
        
        return CGRect(x: newX, y: newY, width: newW, height: newH)
    }
    func DPoint (oldPoint: CGPoint) -> CGPoint {
        let newX = Int((Float(oldPoint.x)/414.0)*Float(UIScreen.main.bounds.width))
        let newY = Int((Float(oldPoint.y)/736.0)*Float(UIScreen.main.bounds.height))
        return CGPoint(x: newX, y: newY)
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dormlist.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // location = dormlist[row]
        // print(location)
        return dormlist[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        location = dormlist[row]
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageStatusButton = UIButton(frame: DFrame (oldFrame: CGRect(x: 300, y: 300, width: 300, height: 50)))
        sendAnotherPage = UIButton(frame: DFrame (oldFrame: CGRect(x: 300, y: 300, width: 300, height: 50)))
        locationPicker = UIPickerView(frame:DFrame (oldFrame: CGRect(x: 20, y: 100, width: 300, height: 100)))
        descriptionField = UITextField(frame: DFrame (oldFrame: CGRect(x: 20, y: 100, width: 300, height: 40)))
        locationField = UITextField(frame: DFrame (oldFrame: CGRect(x: 20, y: 100, width: 300, height: 40)))
        self.view.backgroundColor = .white
        month = calendar.component(.month, from: date as Date)
        year = calendar.component(.year, from: date as Date)
        day = calendar.component(.day, from: date as Date)
        hour = calendar.component(.hour, from: date as Date)
        minute = calendar.component(.minute, from: date as Date)
        second = calendar.component(.second, from: date as Date)
        
        // Do any additional setup after loading the view, typically from a nib.
        locationPicker.center = DPoint (oldPoint: CGPoint(x: 210, y: 120))
        locationPicker.dataSource = self
        locationPicker.delegate = self
        self.view.addSubview(locationPicker)
/*
        locationField.center = DPoint (oldPoint: CGPoint(x: 210, y: 150)
        locationField.placeholder = "Enter Location"
        locationField.font = UIFont.systemFont(ofSize: 15)
        locationField.borderStyle = UITextBorderStyle.roundedRect
        locationField.autocorrectionType = UITextAutocorrectionType.no
        // locationField.backgroundColor = .red
        locationField.keyboardType = UIKeyboardType.default
        locationField.returnKeyType = UIReturnKeyType.done
        locationField.clearButtonMode = UITextFieldViewMode.whileEditing;
        locationField.contentVerticalAlignment =         UIControlContentVerticalAlignment.center
        self.view.addSubview(locationField)
 */
        
        descriptionField.center = DPoint (oldPoint: CGPoint(x: 210, y: 200))
        descriptionField.placeholder = "Describe the Problem"
        descriptionField.font = UIFont.systemFont(ofSize: 15)
        descriptionField.borderStyle = UITextBorderStyle.roundedRect
        descriptionField.autocorrectionType = UITextAutocorrectionType.no
        // locationField.backgroundColor = .red
        descriptionField.keyboardType = UIKeyboardType.default
        descriptionField.returnKeyType = UIReturnKeyType.done
        descriptionField.clearButtonMode = UITextFieldViewMode.whileEditing;
        descriptionField.contentVerticalAlignment =         UIControlContentVerticalAlignment.center
        descriptionField.delegate = self
        self.view.addSubview(descriptionField)
        let pageButton = UIButton(frame: DFrame (oldFrame: CGRect(x: 300, y: 300, width: 300, height: 50)))
        
        pageButton.backgroundColor = UIColor(red: CGFloat(178.0/225.0), green: CGFloat(34.0/225.0), blue: CGFloat(34.0/225.0), alpha: 0.8)
        
        pageButton.center = DPoint (oldPoint: CGPoint(x: 210, y: 300))
        pageButton.setTitle("Page", for: .normal)
        pageButton.addTarget(self, action: #selector(pageAction), for: .touchUpInside)
        pageButton.titleLabel!.textAlignment = .center
        
        pageButton.layer.cornerRadius = 5
        pageButton.setTitleColor(.black , for: .normal)
        
        
 
        self.view.addSubview(pageButton)
        print(selected)
    }
    func pageAction(sender: UIButton!) {
        
        // print(self.locationField.text)
        //self.view.addSubview(locationField)
        
       
        self.calendar = NSCalendar.current
        self.month = calendar.component(.month, from: self.date as Date)
        self.year = calendar.component(.year, from: self.date as Date)
        self.day = calendar.component(.day, from: self.date as Date)
        self.hour = calendar.component(.hour, from: self.date as Date)
        self.minute = calendar.component(.minute, from: self.date as Date)
        self.second = calendar.component(.second, from: self.date as Date)
        let month = String(format: "%02d", self.month)
        let day = String(format: "%02d", self.day)
        let year = String(format: "%04d", self.year)
        let hour = String(format: "%02d", self.hour)
        let minute = String(format: "%02d", self.minute)
        let second = String(format: "%02d", self.second)
        print(self.location)
        
        let date = month + "|" + day + "|" + year + "|" + hour + "|" + minute + "|" + second
        pageRef.updateChildValues([date: ["status": "unresolved", "location" : self.location , "description": self.descriptionField.text! , "name": master.name]])
        
        sender.removeFromSuperview()
        pageStatusButton.backgroundColor = UIColor(red: CGFloat(60.0/225.0), green: CGFloat(179.0/225.0), blue: CGFloat(113.0/225.0), alpha: 0.65)
        pageStatusButton.center = DPoint (oldPoint: CGPoint(x: 210, y: 300))
        pageStatusButton.setTitle("Page Succesfully Sent", for: .normal)
        // pageStatusButton.addTarget(self, action: #selector(pageAction), for: .touchUpInside)
        pageStatusButton.titleLabel!.textAlignment = .center
        
        pageStatusButton.layer.cornerRadius = 5
        pageStatusButton.setTitleColor(.black , for: .normal)
        self.view.addSubview(pageStatusButton)
        
        sender.removeFromSuperview()
        sendAnotherPage.backgroundColor = UIColor(red: CGFloat(178.0/225.0), green: CGFloat(34.0/225.0), blue: CGFloat(34.0/225.0), alpha: 0.8)
        sendAnotherPage.center = DPoint (oldPoint: CGPoint(x: 210, y: 365))
        sendAnotherPage.setTitle("Send Another Page", for: .normal)
        sendAnotherPage.addTarget(self, action: #selector(newAction), for: .touchUpInside)
        sendAnotherPage.titleLabel!.textAlignment = .center
        
        sendAnotherPage.layer.cornerRadius = 5
        sendAnotherPage.setTitleColor(.black , for: .normal)
        self.view.addSubview(sendAnotherPage)
        
    }
    func newAction(sender: UIButton!) {
        descriptionField.text = ""
        locationField.text = ""
        pageStatusButton.removeFromSuperview()
        sendAnotherPage.removeFromSuperview()
        date = NSDate()
        calendar = NSCalendar.current
        self.calendar = NSCalendar.current
        self.month = calendar.component(.month, from: self.date as Date)
        self.year = calendar.component(.year, from: self.date as Date)
        self.day = calendar.component(.day, from: self.date as Date)
        self.hour = calendar.component(.hour, from: self.date as Date)
        self.minute = calendar.component(.minute, from: self.date as Date)
        self.second = calendar.component(.second, from: self.date as Date)
        viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
