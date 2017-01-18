//
//  Login.swift
//  FirePage
//
//  Created by The Ritler on 12/29/16.
//  Copyright © 2016 The Ritler. All rights reserved.
//

import UIKit
import Firebase

class Login: UIViewController, UITextFieldDelegate {
    let master = UIApplication.shared.delegate as! AppDelegate
    let passwordField = UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
    let usernameField = UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
    let userRef = FIRDatabase.database().reference().child("users")
    var label:UILabel = UILabel(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
    let deviceUUID: String = (UIDevice.current.identifierForVendor?.uuidString)!

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("loo")
        textField.resignFirstResponder()
        return true;
    }
    func setX(x: Int) -> Int {
        return Int((Float(x)/414.0)*Float(UIScreen.main.bounds.width))
    }
    func setY(y: Int) -> Int {
        return Int((Float(y)/736.0)*Float(UIScreen.main.bounds.height))
    }
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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        createFields()
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createFields(){
        print("huuuuweee")
        
        usernameField.center = DPoint(oldPoint: CGPoint(x: 210, y: 150))
        usernameField.placeholder = "Username"
        usernameField.font = UIFont.systemFont(ofSize: 15)
        usernameField.borderStyle = UITextBorderStyle.roundedRect
        usernameField.autocorrectionType = UITextAutocorrectionType.no
        // usernameField.backgroundColor = .red
        usernameField.keyboardType = UIKeyboardType.default
        usernameField.returnKeyType = UIReturnKeyType.done
        usernameField.clearButtonMode = UITextFieldViewMode.whileEditing;
        usernameField.contentVerticalAlignment =         UIControlContentVerticalAlignment.center
        usernameField.autocapitalizationType = .none
        usernameField.delegate = self
        self.view.addSubview(usernameField)
        
        passwordField.center = DPoint(oldPoint : CGPoint(x: 210, y: 200))
        passwordField.placeholder = "Password"
        passwordField.font = UIFont.systemFont(ofSize: 15)
        passwordField.borderStyle = UITextBorderStyle.roundedRect
        passwordField.autocorrectionType = UITextAutocorrectionType.no
        // usernameField.backgroundColor = .red
        passwordField.keyboardType = UIKeyboardType.default
        passwordField.returnKeyType = UIReturnKeyType.done
        passwordField.clearButtonMode = UITextFieldViewMode.whileEditing;
        passwordField.contentVerticalAlignment =         UIControlContentVerticalAlignment.center
        passwordField.autocapitalizationType = .none
        passwordField.isSecureTextEntry = true
        passwordField.delegate = self
        self.view.addSubview(passwordField)
        let login = UIButton(frame: DFrame(oldFrame: CGRect(x: 300, y: 300, width: 300, height: 50)))
        
        login.backgroundColor = UIColor(red: CGFloat(0.0/225.0), green: CGFloat(0.0/225.0), blue: CGFloat(220.0/225.0), alpha: 0.65)
        
        login.center = DPoint(oldPoint : CGPoint(x: 210, y: 300))
        login.setTitle("Login", for: .normal)
        login.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        login.titleLabel!.textAlignment = .center
        
        login.layer.cornerRadius = 5
        login.setTitleColor(.white , for: .normal)
        self.view.addSubview(login)
        let signUp = UIButton(frame: DFrame(oldFrame: CGRect(x: 300, y: 300, width: 300, height: 50)))
        
        signUp.backgroundColor = UIColor(red: CGFloat(60.0/225.0), green: CGFloat(179.0/225.0), blue: CGFloat(113.0/225.0), alpha: 0.65)
        
        signUp.center = DPoint(oldPoint : CGPoint(x: 210, y: 370))
        signUp.setTitle("Sign Up", for: .normal)
        signUp.addTarget(self, action: #selector(signUpAction), for: .touchUpInside)
        signUp.titleLabel!.textAlignment = .center
        
        signUp.layer.cornerRadius = 5
        signUp.setTitleColor(.white , for: .normal)
        self.view.addSubview(signUp)
        
    }
    func signUpAction(sendero: UIButton!) {
        signUpSegue()
    }
    func signUpSegue(){
        performSegue(withIdentifier: "tabSegue", sender: self)
    }
    func loginSegue(){
        performSegue(withIdentifier: "loginSegue", sender: self)
    }
    func Segue(){
        if master.level == "client" {
            pageSegue()
        }else{
            loginSegue()
        }
    }
    func pageSegue(){
        performSegue(withIdentifier: "pageSegue", sender: self)
    }
    // performSegue(withIdentifier: "loginSegue", sender: sendero)
    func loginAction(sendero: UIButton!) {
        /*
        var name : String = self.usernameField.text!
        var password : String = String(describing: self.passwordField.text!.hashValue)
        userRef.updateChildValues([ name : ["password": password, "level" : "employee" , "name": "Thorin Oakenshield", "UDID": deviceUUID]])
        
        */
        
        var users = [String: String]()
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            // print( snapshot.value)
            let users : [String: [String : String]] = (snapshot.value as! NSDictionary) as! [String : [String : String]]
            //let username = value?["12282016"] as? String ?? ""
            // print(users[self.usernameField.text!]!["level"]!)
            // self.master.level = users[self.usernameField.text!]!["level"]!
            let keyExists = users[self.usernameField.text!] != nil
            let passwordHash : String! = String(describing: self.passwordField.text!.hashValue)
            
            print(passwordHash)
            if keyExists{
            self.master.level = users[self.usernameField.text!]!["level"]!
            self.master.name = users[self.usernameField.text!]!["name"]!
            if passwordHash == users[self.usernameField.text!]!["password"]! {
                print("is a user")
                
                self.Segue()
            } else {
                
                self.label.center = self.DPoint(oldPoint : CGPoint(x: 210, y: 420))
                self.label.textAlignment = .center
                self.label.text = "Incorrect username or password"
                self.label.textColor = .red
                self.view.addSubview(self.label)
                //print("not user")
                // self.segue()
                }}
                else{
                
                self.label.center = self.DPoint(oldPoint : CGPoint(x: 210, y: 420))
                self.label.textAlignment = .center
                self.label.text = "Incorrect username or password"
                self.label.textColor = .red
                self.view.addSubview(self.label)
            }
            //print(users)
            // self.segue()
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        print(users)
        //userRef.updateChildValues([self.usernameField.text! : self.passwordField.text!])
        // performSegue(withIdentifier: "loginSegue", sender: self)
 
    }
}
