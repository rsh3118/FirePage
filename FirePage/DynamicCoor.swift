//
//  DynamicCGRect.swift
//  FirePage
//
//  Created by The Ritler on 1/17/17.
//  Copyright © 2017 The Ritler. All rights reserved.
//
import Foundation
import UIKit

class DynamicCoor {
    
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
    
   
    
    
}
