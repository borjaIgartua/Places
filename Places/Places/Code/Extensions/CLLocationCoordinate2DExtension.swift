//
//  CLLocationCoordinate2DExtension.swift
//  Places
//
//  Created by Borja Igartua Pastor on 8/6/17.
//  Copyright © 2017 Borja Igartua Pastor. All rights reserved.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D {
    
    static func == (left: CLLocationCoordinate2D, right: CLLocationCoordinate2D) -> Bool {
        return (left.latitude == right.latitude) && (left.longitude == right.longitude)
    }
}
