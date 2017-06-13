//
//  Place+CoreDataClass.swift
//  Places
//
//  Created by Borja Igartua Pastor on 8/6/17.
//  Copyright © 2017 Borja Igartua Pastor. All rights reserved.
//

import Foundation
import CoreData

@objc(Place)
public class Place: NSManagedObject {
    
    var images: [Data]?  {
        get {
            if let image = self.image {
                return NSKeyedUnarchiver.unarchiveObject(with: image as Data) as? [Data]
            }
            return nil
        }
        set {
            if let newValue = newValue {
                self.image = NSData(data: NSKeyedArchiver.archivedData(withRootObject: newValue))
            }
        }
    }
}
