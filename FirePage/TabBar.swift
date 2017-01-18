//
//  TabBar.swift
//  FirePage
//
//  Created by The Ritler on 12/30/16.
//  Copyright © 2016 The Ritler. All rights reserved.
//
// import FireBase
import Foundation
import UIKit

class myTabBar: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let Contact = Page()
        let Calendar = ViewController()
        let MyPages = ResolvePages()
        
        let icon1 = UITabBarItem(title: "Contact", image: UIImage(named: "icon1.png"), selectedImage: UIImage(named: "icon1.png"))
        let icon2 = UITabBarItem(title: "Calendar", image: UIImage(named: "icon1.png"), selectedImage: UIImage(named: "icon1.png"))
        let icon3 = UITabBarItem(title: "My Pages", image: UIImage(named: "icon1.png"), selectedImage: UIImage(named: "icon1.png"))
        Contact.tabBarItem = icon1
        Calendar.tabBarItem = icon2
        MyPages.tabBarItem = icon3
        let controllers = [Contact, Calendar, MyPages]  //array of the root view controllers displayed by the tab bar interface
        self.viewControllers = controllers
    }
    
    //Delegate methods
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("Should select viewController: \(viewController.title) ?")
        return true;
    }
}
