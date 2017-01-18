//
//  Selection.swift
//  FirePage
//
//  Created by The Ritler on 12/28/16.
//  Copyright © 2016 The Ritler. All rights reserved.
//

import Foundation
import UIKit
import Firebase



class Selection: UIViewController {
    let master = UIApplication.shared.delegate as! AppDelegate
    var currentPageStatuses = [String: [String : String]]()
    var alertState = false
    let pageRef = FIRDatabase.database().reference().child("pages").child("Ritwik")
    let monthsOfTheYear:[String] = ["January", "February","March", "April", "May", "June", "July", "August", "September", "October", "Novemeber", "December"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
