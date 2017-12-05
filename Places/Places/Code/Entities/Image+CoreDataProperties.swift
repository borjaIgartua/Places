//
//  Image+CoreDataProperties.swift
//  Places
//
//  Created by Borja Igartua Pastor on 30/11/17.
//  Copyright © 2017 Borja Igartua Pastor. All rights reserved.
//
//

import Foundation
import CoreData


extension Image {

    @nonobjc public class func imageFetchRequest() -> NSFetchRequest<Image> {
        return NSFetchRequest<Image>(entityName: "Image")
    }

    @NSManaged public var content: NSData?
    @NSManaged public var place: Place?

}
