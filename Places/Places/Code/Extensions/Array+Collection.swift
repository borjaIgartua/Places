//
//  Array+Collection.swift
//  Places
//
//  Created by Borja Igartua Pastor on 1/12/17.
//  Copyright © 2017 Borja Igartua Pastor. All rights reserved.
//

import Foundation

extension Array {
    
    /*
     * Creates a new NSSet
     */
    func toNSSet() -> NSSet {
        return NSSet(array: self)
    }
}
