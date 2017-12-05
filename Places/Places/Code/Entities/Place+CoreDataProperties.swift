//
//  Place+CoreDataProperties.swift
//  Places
//
//  Created by Borja Igartua Pastor on 30/11/17.
//  Copyright © 2017 Borja Igartua Pastor. All rights reserved.
//
//

import Foundation
import CoreData


extension Place {

    @nonobjc public class func placeFetchRequest() -> NSFetchRequest<Place> {
        return NSFetchRequest<Place>(entityName: "Place")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var name: String?
    @NSManaged public var placeDescription: String?
    @NSManaged public var images: NSSet?
}

// MARK: Generated accessors for images
extension Place {

    @objc(addImagesObject:)
    @NSManaged public func addToImages(_ value: Image)

    @objc(removeImagesObject:)
    @NSManaged public func removeFromImages(_ value: Image)

    @objc(addImages:)
    @NSManaged public func addToImages(_ values: NSSet)

    @objc(removeImages:)
    @NSManaged public func removeFromImages(_ values: NSSet)
}
