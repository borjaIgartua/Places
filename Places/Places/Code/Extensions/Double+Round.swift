//
//  Double+Round.swift
//  Places
//
//  Created by Borja Igartua Pastor on 9/6/17.
//  Copyright © 2017 Borja Igartua Pastor. All rights reserved.
//

import Foundation

extension Double {
    
    var roundTo7: Double {
        
        let converter = NumberFormatter()
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.none
        formatter.roundingMode = .down
        formatter.maximumFractionDigits = 7
        
        if let stringFromDouble = formatter.string(from: NSNumber(value: self)) {
            if let doubleFromString = converter.number(from: stringFromDouble)?.doubleValue {
                return doubleFromString
            }
        }
        return 0
    }
}
