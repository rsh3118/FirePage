//
//  ViewController.swift
//  Fire Page
//
//  Created by The Ritler on 12/26/16.
//  Copyright © 2016 The Ritler. All rights reserved.
//

import UIKit
import Firebase
class ViewController: UIViewController {
    
    
    func DFrame(oldFrame: CGRect) -> CGRect {
        let newX = Int((Float(oldFrame.minX)/414.0)*Float(UIScreen.main.bounds.width))
        let newY = Int((Float(oldFrame.minY)/736.0)*Float(UIScreen.main.bounds.height))
        let newW = Int((Float(oldFrame.width)/414.0)*Float(UIScreen.main.bounds.width))
        let newH = Int((Float(oldFrame.height)/736.0)*Float(UIScreen.main.bounds.height))
        
        return CGRect(x: newX, y: newY, width: newW, height: newH)
    }
    func DPoint(oldPoint: CGPoint) -> CGPoint {
        print(oldPoint)
        let newX = Int((Float(oldPoint.x)/414.0)*Float(UIScreen.main.bounds.width))
        let newY = Int((Float(oldPoint.y)/736.0)*Float(UIScreen.main.bounds.height))
        return CGPoint(x: newX, y: newY)
    }
    
    
    var master = UIApplication.shared.delegate as! AppDelegate
    var yearLabel = UILabel(frame: CGRect(x: 133, y: 44, width: 69, height: 21))
    var monthLabel = UILabel(frame: CGRect(x: 210, y: 34, width: 129, height: 43))
    var moveLeft = UIButton(frame: CGRect(x: 16, y: 39, width: 37, height: 32))
    var moveRight = UIButton(frame: CGRect(x: 347, y: 25, width: 67, height: 59))
    
    // Data
    
    // Outlets
    // @IBOutlet weak var yearLabel: UILabel!
    // @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var example: UILabel!
    
    // FireBase
    let conditionRef = FIRDatabase.database().reference().child("users")
    let dormsRef = FIRDatabase.database().reference().child("dorms")
    var testFirebaseReturn = ""
    let randolphRef = FIRDatabase.database().reference().child("dorms").child("randolph")
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        dormsRef.observe(.value) { (snap: FIRDataSnapshot ) in
            print((snap.value as AnyObject).description)
            //self.testFirebaseReturn = (snap.value as AnyObject).description
        }
        print("hello", self.testFirebaseReturn, "world")
        
        
        dormsRef.child("randolph").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            // print( snapshot.value)
            let value : [String: String] = (snapshot.value as! NSDictionary) as! [String : String]
            //let username = value?["12282016"] as? String ?? ""
            
            print("new test", value, value["12282016"]!, "gojo")
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    
    // Date 
    var date = NSDate()
    var month = 1
    var year = 1
    var dayArray = [UIButton]()
    var buttonArray = [UIButton]()
    var undoBool = false
    var editMode = false
    
    // RA Data
    var RAs: [String] = ["Lucas","Radhika","Ritwik","Selene"]
    var RAColors = [String:[Float]]()
    var RA: String! = nil
    // var calendar = [String: String]()
    
    // Button Data
    var customButton: UIButton!
    
    // Create Undo Button
    var undo = UIButton(frame: CGRect(x: 310, y: 625, width: 100, height: 50))
    

    override func viewDidLoad() {
        super.viewDidLoad()
        master = UIApplication.shared.delegate as! AppDelegate
        yearLabel = UILabel(frame: DFrame(oldFrame: CGRect(x: 133, y: 44, width: 69, height: 21)))
        monthLabel = UILabel(frame: DFrame(oldFrame: CGRect(x: 210, y: 34, width: 129, height: 43)))
        moveLeft = UIButton(frame: DFrame(oldFrame: CGRect(x: 16, y: 39, width: 37, height: 32)))
        moveRight = UIButton(frame: DFrame(oldFrame: CGRect(x: 347, y: 25, width: 67, height: 59)))
        undo = UIButton(frame: DFrame(oldFrame: CGRect(x: 310, y: 525, width: 100, height: 50)))
        super.view.addSubview(yearLabel)
        super.view.addSubview(monthLabel)
        self.view.backgroundColor = .white
        moveLeft.setTitle("<", for: .normal)
        moveLeft.addTarget(self, action: #selector(prevMonth), for: .touchUpInside)
        moveLeft.titleLabel!.textAlignment = .center
        moveLeft.setTitleColor(.blue , for: .normal)
        self.view.addSubview(moveLeft)
        moveRight.setTitle(">", for: .normal)
        moveRight.addTarget(self, action: #selector(nextMonth), for: .touchUpInside)
        moveRight.titleLabel!.textAlignment = .center
        moveRight.setTitleColor(.blue , for: .normal)
        self.view.addSubview(moveRight)
        // var newCalendar2 = [String: String]()
        // var newCalendar = [String: String]()
        randolphRef.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            // print( snapshot.value)
            
            var newCalendar : [String: String] = (snapshot.value as! NSDictionary) as! [String : String]
            //let username = value?["12282016"] as? String ?? ""
            print("hue1")
            print(newCalendar)
            self.master.calendar = newCalendar
            self.addButtons()
            
            let calendar = NSCalendar.current
            self.month = calendar.component(.month, from: self.date as Date)
            self.year = calendar.component(.year, from: self.date as Date)
            let data = ["Blackwell": ["12292016" : "SE" ]]
            
            // @TODO: optimixe this later
            
            self.dormsRef.updateChildValues(data)
            print(self.year)
            self.fillCalendar(year: self.year, month: self.month)
            // dormRef.setValue("blackwell")
            self.editButton()
            
            // ...
        }) { (error) in
            print("hue")
            print(error.localizedDescription)
        }
        
        //print(newCalendar)
        //master.calendar = newCalendar
        //print("huehuhuehue")
        //print(master.calendar)
        /*
        print("hue2")
        print(newCalendar2)
        addButtons()
        
        let calendar = NSCalendar.current
        month = calendar.component(.month, from: date as Date)
        year = calendar.component(.year, from: date as Date)
        let data = ["Blackwell": ["12292016" : "SE" ]]
        
        // @TODO: optimixe this later
        
        dormsRef.updateChildValues(data)
        
        fillCalendar(year: year, month: month)
        // dormRef.setValue("blackwell")
        editButton() */
        
    }
    
    // RA Actions
    
    
    // Add RA Buttons
    func addButtons(){
        // set initial coordinates and counter
        var xCor = 10
        let yCor = 400
        var counter = 0
        
        // Make color dictionary
        RAColors = ["Lucas":[0.2, 0.4, 0.6],"Ritwik":[0.4, 0.6, 0.8], "Radhika":[0.6,0.8 , 1.0 ], "Selene": [0.4, 0.7, 0.5]]
        
        // Iteratively Create Buttons
        for _ in 1...4 {
            let btn = UIButton(frame: DFrame(oldFrame: CGRect(x: xCor, y: yCor, width: 96, height: 50)))
            let currentRA = RAColors[RAs[counter]]
            btn.backgroundColor = UIColor(red: CGFloat((currentRA?[0])!), green: CGFloat((currentRA?[1])!) , blue: CGFloat((currentRA?[2])!) , alpha: 0.75)
            btn.setTitle(RAs[counter], for: .normal)
            btn.layer.cornerRadius = 5
            btn.addTarget(self, action: #selector(RAAction), for: .touchUpInside)
            self.view.addSubview(btn)
            xCor = xCor + 100
            counter += 1
        }
    }
    // Add RA Button Action
    func RAAction(sender: UIButton!) {
        if editMode {
        undoBool = false
        // set current RA
        let temp1 : String! = sender.currentTitle
        RA = temp1
        
        // Print action
        print( temp1 , "was clicked")
        
        }
    }
    

    // Calendar Actions
    
    func fillCalendar(year: Int, month: Int){
        // Set Month and Year
        let monthsOfWeek: [String] = ["January","February","March", "April","May","June","July","August","September","October","November","December"]
        
        yearLabel.text = String(year)
        monthLabel.text = monthsOfWeek[month-1]
        
        // Fill Calendar
        setCalendar(dayX: getFirstofMonth(year: year, month: month))
    }
    
    func getFirstofMonth(year: Int, month: Int) -> Int{
        // Initialize Date components
        let c = NSDateComponents()
        c.year = year
        c.month = month
        c.day = 1
        
        // Get NSDate given the above date components
        let dateX = NSCalendar(identifier: NSCalendar.Identifier.gregorian)?.date(from: c as DateComponents)
        let day = dateX!.dayNumberOfWeek()!
        return day
        
    }
    func setCalendar(dayX: Int){
        // Set up intial coordinates and counter for day of the week setting
        var xCoor = 27
        let yCoor = 90
        var countero = 0
        var daysofWeek: [String] = ["Sun", "Mon", "Tues", "Wed", "Thurs", "Fri", "Sat"]
        
        
        // Iteratively set up day if the week overhead
        for _ in 1...7{
            let btn = UIButton(frame: DFrame(oldFrame: CGRect(x: xCoor, y: yCoor, width: 80, height: 21)))
            print(xCoor, yCoor)
            btn.center = DPoint(oldPoint: CGPoint(x: xCoor,y: yCoor))
            btn.setTitle(daysofWeek[countero], for: .normal)
            // btn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            btn.titleLabel!.textAlignment = .center
            btn.setTitleColor(.blue , for: .normal)
            self.view.addSubview(btn)
            xCoor = xCoor + 60
            countero += 1
            dayArray.append(btn)
            
        }
        
        // Set up initial coordinates, counter, endCondition, and first day
        var day = dayX
        var counter = 1
        var xCor = 27 + (day-1)*60
        var yCor = 120
        var endCond = 31
        if month == 9 || month == 4 || month == 6 || month == 11{
            endCond = 30
        }else if month == 2 {
            if year%4 == 0 {
                endCond = 29
            }else{
                endCond = 28
            }
        }else{
            endCond = 31
        }
        
        // Iteratively fill Calendar
        for _ in 1...endCond{
            let btn = UIButton(frame: DFrame(oldFrame: CGRect(x: xCor, y: yCor, width: 58, height: 18)))
            var colors = dateFilled(day: counter)
            btn.backgroundColor = UIColor(red: CGFloat((colors[0])), green: CGFloat((colors[1])) , blue: CGFloat((colors[2])) , alpha: 0.5)
            
            btn.center = DPoint(oldPoint: CGPoint(x: xCor,y: yCor))
            btn.setTitle("\(counter)", for: .normal)
            btn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            btn.titleLabel!.textAlignment = .center
            btn.layer.cornerRadius = 5
            btn.setTitleColor(.black , for: .normal)
            
            self.view.addSubview(btn)
            xCor = xCor + 60
            counter += 1
            if day%7 == 0{
                yCor += 20
                xCor = 27
            }
            day = day + 1
            buttonArray.append(btn)
            
        }
    }
    
    func dateFilled(day: Int) -> [Float] {
        // Get date components adn convert to string
        let month = String(format: "%02d", self.month)
        let day = String(format: "%02d", day)
        let year = String(format: "%04d", self.year)
        
        //Construct key calendar
        let calendarKey = month + "" + day + "" + year
        
        if master.calendar[calendarKey] != nil && master.calendar[calendarKey] != "No RA" {
            // now val is not nil and the Optional has been unwrapped, so use it
            print(master.calendar[calendarKey])
            //print("color")
            return RAColors[master.calendar[calendarKey]!]!
        }else{
            //print("no color")
            return [1,1,1]
        }
    }
    func prevMonth(sender: UIButton) {
        // Clear the Screen
        clearScreen()
        
        
        // Update Month
        month = month - 1
        if month == 0 {
            year = year - 1
            month = 12
        }
        print(master.calendar)
        fillCalendar(year: year , month: month)
    }
    
    func nextMonth( sender: UIButton) {
         // Clear the Screen
        clearScreen()
        
        
        month = month + 1
        
        // Update Month
        if month > 12 {
            year = year + 1
        }
        if month != 12{
            month = month%12
        }
        print(master.calendar)
        fillCalendar(year: year , month: month)
    }
    
    // Add to Calendar
    func addToCalendar(day: Int){
        // Get date components adn convert to string
        let month = String(format: "%02d", self.month)
        let day = String(format: "%02d", day)
        let year = String(format: "%04d", self.year)
        
        //Construct key calendar
        let calendarKey = month + "" + day + "" + year
        if RA == nil{
            print("no RA")
        }
        if RA != nil{
            master.calendar[calendarKey] = RA
        }else{
            master.calendar[calendarKey] = nil
        }
        /*
        if master.calendar[calendarKey] != nil {
            print(calendarKey + " , " + master.calendar[calendarKey]!)
        }else{
            print(calendarKey + " , " + "nothing")
        }
        */
        // @TODO: Add the code to update calendar
        let data = master.calendar
        
        // @TODO: optimixe this later
        
        randolphRef.updateChildValues(data)
        
    }

    
    func buttonAction(sender: UIButton!) {
        // get Day Number
        let temp1 : String! = sender.currentTitle
        
        
        // set button color to RA color
        if RA != "No RA" && RA != nil {
            var currentRA = RAColors[RA]
            sender.backgroundColor = UIColor(red: CGFloat((currentRA?[0])!), green: CGFloat((currentRA?[1])!) , blue: CGFloat((currentRA?[2])!) , alpha: 0.5)
        }
        if undoBool == true {
            RA = "No RA"
            sender.backgroundColor = .white
        }
        addToCalendar(day: Int(temp1)!)
        // Print action
        print( temp1 , "was clicked")
    }
    
    // Edit, Escape, and Clear Actions
    
    func clearScreen(){
        // Clear Calendar Days
        for label in buttonArray{
            label.removeFromSuperview()
        }
        
        // Clear Overview Days
        for label in dayArray{
            label.removeFromSuperview()
        }
    }
    
    func editButton(){
        let edit = UIButton(frame: DFrame(oldFrame: CGRect(x: 310, y: 580, width: 100, height: 50)))
        edit.setTitle("Edit Mode", for: .normal)
        edit.backgroundColor = .black
        edit.setTitleShadowColor(.white, for: .normal)
        edit.layer.cornerRadius = 5
        edit.setTitleColor(.white, for: .normal)
        edit.addTarget(self, action: #selector(editAction), for: .touchUpInside)
        self.view.addSubview(edit)
        
    }
    func editAction(sender: UIButton!){
        editMode = true
        undoBool = true
        createEscape()
    }
    func createEscape(){
        // Create escape button
        let esc = UIButton(frame: DFrame(oldFrame: CGRect(x: 310, y: 580, width: 100, height: 50)))
        esc.setTitle("Escape", for: .normal)
        esc.backgroundColor = .black
        esc.setTitleShadowColor(.white, for: .normal)
        esc.layer.cornerRadius = 5
        esc.setTitleColor(.white, for: .normal)
        esc.addTarget(self, action: #selector(escapeAction), for: .touchUpInside)
        self.view.addSubview(esc)
        
        // modify undo button 
        undo.setTitle("Clear", for: .normal)
        undo.backgroundColor = .gray
        undo.setTitleShadowColor(.white, for: .normal)
        undo.setTitleColor(.white, for: .normal)
        undo.layer.cornerRadius = 5
        undo.addTarget(self, action: #selector(undoAction), for: .touchUpInside)
        self.view.addSubview(undo)
    }
    
    func undoAction(sender: UIButton!){
        undoBool = true
    }
    
    func escapeAction(sender: UIButton!) {
        // Remove RA
        undoBool = false
        RA = nil
        
        // Remove Escape Button
        sender.removeFromSuperview()
        undo.removeFromSuperview()
        
    }
    
    
    
    
    /*
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    */
    
}

