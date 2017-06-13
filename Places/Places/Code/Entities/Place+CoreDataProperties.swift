//
//  Place+CoreDataProperties.swift
//  Places
//
//  Created by Borja Igartua Pastor on 11/6/17.
//  Copyright © 2017 Borja Igartua Pastor. All rights reserved.
//

import Foundation
import CoreData


extension Place {

    @nonobjc public class func placeFetchRequest() -> NSFetchRequest<Place> {
        return NSFetchRequest<Place>(entityName: "Place")
    }

    @NSManaged public var image: NSData?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var name: String?
    @NSManaged public var placeDescription: String?

}
