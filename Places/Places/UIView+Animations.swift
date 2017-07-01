//
//  UIView+Animations.swift
//  Places
//
//  Created by Borja Igartua Pastor on 1/7/17.
//  Copyright © 2017 Borja Igartua Pastor. All rights reserved.
//

//Animatable properties
// https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/CoreAnimation_guide/AnimatableProperties/AnimatableProperties.html

import UIKit

extension UIView {
    
    func startFloatingAnimation() {
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 1.5
        animation.repeatCount = Float.infinity
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x, y: self.center.y - 5))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
    
    func stopFloatingAnimation() {
        self.layer.removeAnimation(forKey: "position")
    }
}
