//
//  Error.swift
//  Places
//
//  Created by Borja Igartua Pastor on 8/6/17.
//  Copyright © 2017 Borja Igartua Pastor. All rights reserved.
//

import Foundation

enum PlacesError: Error {
    case unknown
    case NoData
    case NamePlaceIsRequired
}
