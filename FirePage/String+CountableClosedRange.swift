//
//  String+CountableClosedRange.swift
//  FirePage
//
//  Created by The Ritler on 12/29/16.
//  Copyright © 2016 The Ritler. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    
    func trim() -> String
    {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
}
