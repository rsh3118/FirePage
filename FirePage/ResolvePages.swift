//
//  ResolvePages.swift
//  FirePage
//
//  Created by The Ritler on 12/29/16.
//  Copyright © 2016 The Ritler. All rights reserved.
//
import UIKit
import Firebase
import Foundation

class ResolvePages: UIViewController, UITableViewDelegate,UITableViewDataSource {
    let scrollView = UIScrollView(frame: UIScreen.main.bounds)
    let master = UIApplication.shared.delegate as! AppDelegate
    var currentPageStatuses = [String: [String : String]]()
    var alertState = false
    let pageRef = FIRDatabase.database().reference().child("pages").child("Ritwik")
    let monthsOfTheYear:[String] = ["January", "February","March", "April", "May", "June", "July", "August", "September", "October", "Novemeber", "December"]
    var selectedRow = String()
    var tableView: UITableView  =   UITableView()
    var unresolved = [String]()
    var animals = [String]()
    var info = [String: [String : String]]()
    /*= ["Harshil": ["phone": "5585484455", "location": "East House", "decription": "loves league"], "Ritwik": ["phone": "9726559320", "location": "randolpho", "decription": "PPAP"], "Radhika" :["phone": "5583542288", "location": "randolpho", "decription": "is a nerd"], "Cheenu": ["phone": "9864568920", "location": "Kilgo", "decription": "coolo"], "Jane" : ["phone": "5585445455", "location": "blackwell", "decription": "loves japan"], "Lucas" : ["phone": "558543484455", "location": "randolpho", "decription": "is amazing"]] */
    
    var name = UILabel(frame: CGRect(x: 0, y: 200, width: 300, height: 50))
    var number = UILabel(frame: CGRect(x: 0, y: 200, width: 300, height: 50))
    var desc = UILabel(frame: CGRect(x: 0, y: 200, width: 300, height: 50))
    var loc = UILabel(frame: CGRect(x: 0, y: 200, width: 300, height: 50))
    var resolveButton = UIButton(frame: CGRect(x: 0, y: 200, width: 100, height: 50))
    let screenSize: CGRect = UIScreen.main.bounds
    var date = NSDate()
    var calendar = NSCalendar.current
    var month = 1
    var year = 1
    var day = 1
    var hour = 1
    var minute = 1
    var second = 1
    var daytoDate = [String: String]()
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
    
    
    
    
    
    //let myView = MyCustomView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.height - 100 ))
    let viewX = UIScreen.main.bounds.width
    let viewY = UIScreen.main.bounds.height
    var popupElements = [UIView]()
    
    func exitButton(sendero: UIButton!) {
        clearPopup()
    }
    
    func enterAction(sendero: UIButton!) {
        if let index = unresolved.index(of: selectedRow) {
            unresolved.remove(at: index)
        }
        info[selectedRow]!["status"] = "resolved"
        
        // pageRef.setValue(self.info)
        pageRef.updateChildValues(self.info)
        // animals.removeAll()
        tableView.reloadData()
        clearPopup()
    }
    
    func clearPopup(){
        for element in popupElements {
            element.removeFromSuperview()
        }
    }
    
    func createPopup(){
        
        let PopupFrame = DFrame (oldFrame: CGRect(x: viewX/2 , y: viewY/2, width: viewX - 100, height: viewY - 200 ))
        
        
        let PopupX = UIButton(frame: DFrame(oldFrame: CGRect(x : 0, y: 0, width: 20, height: 20)))
        var Popup = UIView(frame: PopupFrame)
        Popup.center = DPoint (oldPoint: CGPoint(x: viewX/2 , y: viewY/2))
        PopupX.center = DPoint (oldPoint: CGPoint(x: viewX - 65, y : 115 ))
        Popup.backgroundColor = .white
        PopupX.backgroundColor = .red
        PopupX.setTitle("X", for: .normal)
        popupElements.append(Popup)
        popupElements.append(PopupX)
        Popup.layer.cornerRadius = 10
        Popup.layer.shadowRadius = 10.0;
        Popup.layer.shadowOpacity = 0.5;
        PopupX.layer.cornerRadius = 10
        PopupX.addTarget(self, action: #selector(exitButton), for: .touchUpInside)
        var enterButton = UIButton(frame: DFrame (oldFrame: CGRect(x: 0, y: 200, width: 100, height: 50)))
        enterButton.center = DPoint (oldPoint: CGPoint(x: viewX/2 , y: viewY/2))
        enterButton.backgroundColor = .green
        enterButton.setTitle("Enter", for: .normal)
        enterButton.addTarget(self, action: #selector(enterAction), for: .touchUpInside)
        popupElements.append(enterButton)
        self.view.addSubview(PopupX)
        self.view.addSubview(Popup)
        self.view.bringSubview(toFront: PopupX)
        self.view.addSubview(enterButton)
        self.view.bringSubview(toFront: enterButton)
        
        
        
        
    }
    
    // var scrollView: UIScrollView!
    func resolveAction(sendero: UIButton!) {
        
        // myView.backgroundColor = .black
        //myView.center = DPoint (oldPoint: CGPoint(x: 250, y: 225)
        //self.view.addSubview(myView)
        //self.view.bringSubview(toFront: myView)
        createPopup()
        
        
        
        // tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(5)
        
        name = UILabel(frame: DFrame (oldFrame: CGRect(x: 0, y: 200, width: 300, height: 50)))
        number = UILabel(frame: DFrame (oldFrame: CGRect(x: 0, y: 200, width: 300, height: 50)))
        desc = UILabel(frame: DFrame (oldFrame: CGRect(x: 0, y: 200, width: 300, height: 50)))
        loc = UILabel(frame: DFrame (oldFrame: CGRect(x: 0, y: 200, width: 300, height: 50)))
        var resolveButton = UIButton(frame: DFrame (oldFrame: CGRect(x: 0, y: 200, width: 100, height: 50)))
        self.view.backgroundColor = .white
        self.calendar = NSCalendar.current
        self.month = calendar.component(.month, from: self.date as Date)
        self.year = calendar.component(.year, from: self.date as Date)
        self.day = calendar.component(.day, from: self.date as Date)
        self.hour = calendar.component(.hour, from: self.date as Date)
        self.minute = calendar.component(.minute, from: self.date as Date)
        self.second = calendar.component(.second, from: self.date as Date)
        var month = String(format: "%02d", self.month)
        var day = String(format: "%02d", self.day)
        var year = String(format: "%04d", self.year)
        var hour = String(format: "%02d", self.hour)
        var minute = String(format: "%02d", self.minute)
        var second = String(format: "%02d", self.second)
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        pageRef.observe(.value) { (snapshot: FIRDataSnapshot ) in
            var value : [String: [String : String]] = (snapshot.value as! NSDictionary) as! [String : [String : String]]
            
            print(value)
            self.animals.removeAll()
            self.unresolved.removeAll()
            for (time, data) in value {
                /*
                if data["status"] == "unresolved"{
                    self.unresolved.append(time)
                }
                self.animals.append(time)
 */
                if data["name"] ==  nil {
                    value.removeValue(forKey: time)
                    print("deleteo")
                }else{
                    var dateComponents : [String] = time.components(separatedBy: "|")
                    var monthText : String! = dateComponents[0]
                    var dayText : String! = dateComponents[1]
                    var yearText : String! = dateComponents[2]
                    var hourText : String! = dateComponents[3]
                    var minuteText : String! = dateComponents[4]
                    if monthText == month && yearText == year && dayText == day {
                        print("foundo")
                        let montho : String! = self.monthsOfTheYear[Int(dateComponents[0])! - 1]
                        let englishDate = montho + " " + dayText + ", " + yearText + " " + hourText + ":" + minuteText
                        self.daytoDate[englishDate] = time
                    if data["status"] == "unresolved"{
                        self.unresolved.append(englishDate)
                    }
                    
                    self.animals.append(englishDate)
                    }
                }
                
            }
            self.animals.sort()
            self.animals.reverse()
            print(self.daytoDate)
            self.info = value
            for (time, data) in value {
                
                if data["name"] ==  nil {
                    // value.removeValue(forKey: time)
                    print("existo")
                }
                
            }
            //self.testFirebaseReturn =(snap.value as AnyObject).description
            self.resolveButton.center = self.DPoint (oldPoint: CGPoint(x: 250, y: 225))
            self.resolveButton.backgroundColor = .green
            self.resolveButton.setTitle("Resolve", for: .normal)
            self.resolveButton.addTarget(self, action: #selector(self.resolveAction), for: .touchUpInside)
            
            self.view.addSubview(self.resolveButton)
            
            self.name.center = self.DPoint (oldPoint: CGPoint(x: 210, y: 75))
            self.number.center = self.DPoint (oldPoint: CGPoint(x: 210, y: 125))
            self.desc.center = self.DPoint (oldPoint: CGPoint(x: 210, y: 225))
            self.loc.center = self.DPoint (oldPoint: CGPoint(x: 210, y: 175))
            
            
            
            self.name.text = "Name"
            self.number.text = "XXXXXXXXXX"
            self.desc.text = "NA"
            self.loc.text = "No location"
            self.view.addSubview(self.name)
            self.view.addSubview(self.number)
            self.view.addSubview(self.desc)
            self.view.addSubview(self.loc)
            
            self.tableView = UITableView(frame: CGRect(x: 0, y: 250, width: 400, height: 500), style: UITableViewStyle.plain)
            self.tableView.delegate      =   self
            self.tableView.dataSource    =   self
            self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            let numberOfSections = self.tableView.numberOfSections
            let numberOfRows = self.tableView.numberOfRows(inSection: numberOfSections-1)
            
            let indexPath = IndexPath(row: numberOfRows-1 , section: numberOfSections-1)
            // self.tableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.bottom, animated: true)
            //scrollView = UIScrollView(frame: view.bounds)
            //scrollView.backgroundColor = UIColor.black
            // scrollView.contentSize = imageView.bounds.size
            // scrollView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
            
            // scrollView.addSubview(imageView)
            ///view.addSubview(scrollView)
            
            self.view.addSubview(self.tableView)
            // self.alert(dict: value)
            
        }
    }
    func alertAction(sender: SpecialButton!) {
        self.alertState = false
        self.currentPageStatuses[sender.hiddenText1]!["status"] = "resolved"
        
        pageRef.updateChildValues(self.currentPageStatuses)
        sender.removeFromSuperview()
        
        
        
    }
    func alert (dict : [String: [String: String]]){
        for (time, info) in dict {
            if info["status"] == "unresolved"{
                print("hehehe")
                self.alertState = true
                let btn = SpecialButton(frame: DFrame (oldFrame: CGRect(x: 50, y: 550, width: 200, height: 200)))
                btn.backgroundColor = .purple
                btn.center = DPoint (oldPoint: CGPoint(x: 210, y: 550))
                let dateComponents : [String] = time.components(separatedBy: "|")
                print(dateComponents)
                var text = String()
                let monthText : String! = monthsOfTheYear[Int(dateComponents[0])! - 1]
                let dayText : String! = dateComponents[1]
                let yearText : String! = dateComponents[2]
                let hourText : String! = dateComponents[3]
                let minuteText : String! = dateComponents[4]
                let locationText : String = info["location"]!
                let descriptionText : String! = info["description"]!
                text = "Day: " + monthText + " " + dayText + ", " + yearText + "\nHour: " + hourText + ":" + minuteText + "\nLocation: " + locationText + "\nDescription: " + descriptionText + "\nName: " + master.name
                
                btn.hiddenText1 = time
                btn.titleLabel?.numberOfLines = 0
                
                
                btn.setTitle(text, for: .normal)
                btn.addTarget(self, action: #selector(alertAction), for: .touchUpInside)
                btn.titleLabel!.textAlignment = .center
                
                btn.layer.cornerRadius = 50
                btn.setTitleColor(.black , for: .normal)
                
                self.view.addSubview(btn)
                /*
                 while true {
                 if(alertState == false){
                 break
                 }else{
                 continue
                 }
                 }
                 */
                
                
            }
            
            
        }
        self.currentPageStatuses = dict
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return animals.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell:UITableViewCell=UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cell")
        cell.textLabel!.text = animals [indexPath.row]
        if unresolved.contains(animals[indexPath.row]) {
            cell.backgroundColor = .red
        }else{
            
        }
        
        return cell;
    }
    func connected(sender: UIButton!) {
        
        print("connection successful")
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        print(indexPath)
        let a : String = info[daytoDate[animals[indexPath.row]]!]!["name"]!
        let b : String = info[daytoDate[animals[indexPath.row]]!]!["location"]!
        let c : String = info[daytoDate[animals[indexPath.row]]!]!["description"]!
        
        name.text = animals[indexPath.row]
        number.text = a
        loc.text = b
        desc.text = c
        selectedRow = daytoDate[animals[indexPath.row]]!
        print(info[animals[indexPath.row]])
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    }

