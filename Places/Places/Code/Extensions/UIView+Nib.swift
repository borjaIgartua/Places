//
//  UIView+Nib.swift
//  Places
//
//  Created by Borja Igartua Pastor on 9/6/17.
//  Copyright © 2017 Borja Igartua Pastor. All rights reserved.
//

import UIKit

extension UIView {
    
    class func loadFromNib(nibName name: String, bundle : Bundle? = nil) -> UIView {
        return UINib(
            nibName: name,
            bundle: bundle
            ).instantiate(withOwner: self, options: nil)[0] as! UIView
    }
}
