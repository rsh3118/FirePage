//
//  SignUp.swift
//  FirePage
//
//  Created by The Ritler on 12/30/16.
//  Copyright © 2016 The Ritler. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class SignUp: UIViewController {
    let master = UIApplication.shared.delegate as! AppDelegate
    let passwordField = UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
    let secondPasswordField = UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
    let usernameField = UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
    let nameField = UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
    let userRef = FIRDatabase.database().reference().child("users")
    var label:UILabel = UILabel(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
    let deviceUUID: String = (UIDevice.current.identifierForVendor?.uuidString)!
    let badCharSet = CharacterSet(charactersIn: ".$[]#/:()\\")
    let letterSet = CharacterSet(charactersIn:"zxcvbnmasdfghjklqwertyuiopZXCVBNMASDFGHJKLQWERTYUIOP")
    let numberSet = CharacterSet(charactersIn: "1234567890")
    let specialSet = CharacterSet(charactersIn: ",/;'|`-=<>?~!@%^&*+")
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
    
    func createFields(){
        let passwordReqs = SpecialButton(frame: DFrame(oldFrame: CGRect(x: 50, y: 590, width: 380, height: 200)))
        passwordReqs.backgroundColor = .white
        passwordReqs.center = DPoint (oldPoint: CGPoint(x: 210, y: 580))
        // passwordReqs.hiddenText1 = time
        passwordReqs.titleLabel?.numberOfLines = 0
        
        let text : String = "\nPassword must contain letters numbers and valid special characters  \n \nInvalid special characters are .$[]#/:()\\"
        passwordReqs.setTitle(text, for: .normal)
        // passwordReqs.addTarget(self, action: #selector(alertAction), for: .touchUpInside)
        passwordReqs.titleLabel!.textAlignment = .center
        
        passwordReqs.layer.cornerRadius = 5
        passwordReqs.setTitleColor(.gray , for: .normal)
        self.view.addSubview(passwordReqs)
        
        print("huuuuweee")
        self.label.center = DPoint (oldPoint: CGPoint(x: 210, y: 510))
        self.label.textAlignment = .center
        self.label.text = ""
        self.label.textColor = .red
        self.view.addSubview(self.label)
        usernameField.center = DPoint (oldPoint: CGPoint(x: 210, y: 150))
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
        self.view.addSubview(usernameField)
        
        passwordField.center = DPoint (oldPoint: CGPoint(x: 210, y: 200))
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
        self.view.addSubview(passwordField)
        
        nameField.center = DPoint (oldPoint: CGPoint(x: 210, y: 300))
        nameField.placeholder = "Please Enter Full Name"
        nameField.font = UIFont.systemFont(ofSize: 15)
        nameField.borderStyle = UITextBorderStyle.roundedRect
        nameField.autocorrectionType = UITextAutocorrectionType.no
        // usernameField.backgroundColor = .red
        nameField.keyboardType = UIKeyboardType.default
        nameField.returnKeyType = UIReturnKeyType.done
        nameField.clearButtonMode = UITextFieldViewMode.whileEditing;
        nameField.contentVerticalAlignment =         UIControlContentVerticalAlignment.center
        nameField.autocapitalizationType = .none
        self.view.addSubview(nameField)
        
        secondPasswordField.center = DPoint (oldPoint: CGPoint(x: 210, y: 250))
        secondPasswordField.placeholder = "Re-enter Password"
        secondPasswordField.font = UIFont.systemFont(ofSize: 15)
        secondPasswordField.borderStyle = UITextBorderStyle.roundedRect
        secondPasswordField.autocorrectionType = UITextAutocorrectionType.no
        // usernameField.backgroundColor = .red
        secondPasswordField.keyboardType = UIKeyboardType.default
        secondPasswordField.returnKeyType = UIReturnKeyType.done
        secondPasswordField.clearButtonMode = UITextFieldViewMode.whileEditing;
        secondPasswordField.contentVerticalAlignment =         UIControlContentVerticalAlignment.center
        secondPasswordField.autocapitalizationType = .none
        secondPasswordField.isSecureTextEntry = true
        self.view.addSubview(secondPasswordField)
        
        
        let signUp = UIButton(frame: DFrame(oldFrame: CGRect(x: 300, y: 300, width: 300, height: 50)))
        
        signUp.backgroundColor = UIColor(red: CGFloat(60.0/225.0), green: CGFloat(179.0/225.0), blue: CGFloat(113.0/225.0), alpha: 0.65)
        
        signUp.center = DPoint (oldPoint: CGPoint(x: 210, y: 380))
        signUp.setTitle("Sign Up", for: .normal)
        signUp.addTarget(self, action: #selector(signUpAction), for: .touchUpInside)
        signUp.titleLabel!.textAlignment = .center
        
        signUp.layer.cornerRadius = 5
        signUp.setTitleColor(.white , for: .normal)
        self.view.addSubview(signUp)
        let backToLogin = UIButton(frame: DFrame(oldFrame: CGRect(x: 300, y: 300, width: 300, height: 50)))
        
        backToLogin.backgroundColor = UIColor(red: CGFloat(135.0/225.0), green: CGFloat(206.0/225.0), blue: CGFloat(250.0/225.0), alpha: 0.9)
        
        backToLogin.center = DPoint (oldPoint: CGPoint(x: 210, y: 450))
        backToLogin.setTitle("Back to Login", for: .normal)
        backToLogin.addTarget(self, action: #selector(backToLoginAction), for: .touchUpInside)
        backToLogin.titleLabel!.textAlignment = .center
        
        backToLogin.layer.cornerRadius = 5
        backToLogin.setTitleColor(.white , for: .normal)
        self.view.addSubview(backToLogin)
    }
    func backToLoginAction(sendero: UIButton!) {
        toLoginSegue()
    }
    func signUpAction(sendero: UIButton!) {
        let passwordo : String = passwordField.text!
        
        let passwordContainsBad : Bool = passwordo.lowercased().rangeOfCharacter(from: badCharSet) != nil
        let containsLetter : Bool = passwordo.lowercased().rangeOfCharacter(from: letterSet) != nil
        let containsNumber : Bool = passwordo.lowercased().rangeOfCharacter(from: numberSet) != nil
        let containsSpecial : Bool = passwordo.lowercased().rangeOfCharacter(from: specialSet) != nil
        let isSame: Bool = passwordField.text! == secondPasswordField.text!
        var username : String = self.usernameField.text!
        username = username.trim()
        let password : String = String(describing: self.passwordField.text!.hashValue)
        var name : String = self.nameField.text!
        name = name.trim()
        let usernameContainsBad : Bool = username.lowercased().rangeOfCharacter(from: badCharSet) != nil
        let nameContainsBad : Bool = name.lowercased().rangeOfCharacter(from: badCharSet) != nil
        let usernameEmpty = username == ""
        let nameEmpty = name == ""
        print(passwordContainsBad, containsLetter, containsNumber, containsSpecial, isSame)
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            let users : [String: [String : String]] = (snapshot.value as! NSDictionary) as! [String : [String : String]]
            let keyExists = users[self.usernameField.text!] != nil
            if !usernameEmpty && !usernameContainsBad {
            if !nameContainsBad && !nameEmpty{
            if !keyExists {
        if isSame {
        if( !passwordContainsBad && containsLetter && containsNumber && containsSpecial){
        self.master.level = "client"
        self.master.name = self.nameField.text!
        self.userRef.updateChildValues([ username : ["password": password, "level" : "client" , "name": name, "UDID": self.deviceUUID]])
        self.segue()
        }else{
            self.label.text = "Doesn't adhere to Password rules"
            }
            
        }else{
            self.label.text = "Passwords don't match"
        }
            
            }else{
                self.label.text = "User already exists"
            }
            } else{
                self.label.text = "Name is invalid"
            }
            } else {
                self.label.text = "Username is invalid"
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    func segue(){
        if master.level == "client" {
            pageSegue()
        }else{
            toSelectionSegue()
        }
    }
    func toLoginSegue(){
        performSegue(withIdentifier: "toLoginSegue", sender: self)
    }
    func toSelectionSegue(){
        performSegue(withIdentifier: "toSelectionSegue", sender: self)
    }
    func pageSegue(){
        performSegue(withIdentifier: "pageSegue", sender: self)
    }
    func loginAction(sendero: UIButton!) {
        var name : String = self.usernameField.text!
        var password : String = String(describing: self.passwordField.text!.hashValue)
        userRef.updateChildValues([ name : ["password": password, "level" : "employee" , "name": "Thorin Oakenshield", "UDID": deviceUUID]])
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
