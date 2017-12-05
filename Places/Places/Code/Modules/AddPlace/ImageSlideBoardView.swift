//
//  ImageSlideBoardView.swift
//  Places
//
//  Created by Borja Igartua Pastor on 11/6/17.
//  Copyright © 2017 Borja Igartua Pastor. All rights reserved.
//

import UIKit

class ImageSlideBoardView: UIView {
    
    let contentScrollView = UIScrollView()
    let contentAddView = UIView()
    var contentConstraints = [NSLayoutConstraint]()
    var contentViews = [UIView]()
    
    weak var delegate: ImageSlideBoardViewDelegate?
    
    var images = [UIImage]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setupView()
    }
    
    private func setupView() {
        
        
        contentScrollView.translatesAutoresizingMaskIntoConstraints = false
        contentScrollView.backgroundColor = UIColor.lightGray
        contentScrollView.layer.cornerRadius = 5.0
        contentScrollView.alwaysBounceHorizontal = true
        contentScrollView.isScrollEnabled = true
        self.addSubview(contentScrollView)
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[contentScrollView]|", options: [], metrics: nil, views: ["contentScrollView" : contentScrollView]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[contentScrollView]|", options: [], metrics: nil, views: ["contentScrollView" : contentScrollView]))
        
        
        contentAddView.translatesAutoresizingMaskIntoConstraints = false
        contentAddView.backgroundColor = UIColor.lightText
        contentAddView.alpha = 0.8
        contentAddView.layer.cornerRadius = 15.0
        contentAddView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ImageSlideBoardView.addNewImage)))
        
        let addImageView = UIImageView()
        addImageView.translatesAutoresizingMaskIntoConstraints = false
        addImageView.image = UIImage(named: "add_icon")
        contentAddView.addSubview(addImageView)
        
        contentAddView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[addImageView]-10-|", options: [], metrics: nil, views: ["addImageView" : addImageView]))
        contentAddView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[addImageView]-10-|", options: [], metrics: nil, views: ["addImageView" : addImageView]))
        
        contentScrollView.addSubview(contentAddView)
        
        let views =  ["contentView" : contentAddView]
        contentScrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[contentView]",
                                                                       options: [],
                                                                       metrics: nil,
                                                                       views:views))
        
        
        contentScrollView.addConstraint(NSLayoutConstraint(item: contentAddView,
                                                           attribute: .height,
                                                           relatedBy: .equal,
                                                           toItem: contentScrollView,
                                                           attribute: .height,
                                                           multiplier: 1.0,
                                                           constant: -10.0))
        contentScrollView.addConstraint(NSLayoutConstraint(item: contentAddView,
                                                           attribute: .width,
                                                           relatedBy: .equal,
                                                           toItem: contentScrollView,
                                                           attribute: .height,
                                                           multiplier: 1.0,
                                                           constant: -10.0))
        
        contentConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[contentView]",
                                                                        options: [],
                                                                        metrics: nil,
                                                                        views: views))
        
        contentScrollView.addConstraints(self.contentConstraints)
    }
    
    @objc private func addNewImage() {
        delegate?.addImage()
    }
    
    func addImage(_ image: UIImage, animate: Bool = true) {
        
        let addImageView = UIImageView()
        addImageView.translatesAutoresizingMaskIntoConstraints = false
        addImageView.layer.cornerRadius = 15.0
        addImageView.layer.masksToBounds = true
        addImageView.image = image
        contentScrollView.insertSubview(addImageView, at: 0)
        contentViews.append(addImageView)
        
        contentScrollView.removeConstraints(self.contentConstraints)
        self.contentConstraints.removeAll()
        
        var horizontalConstraints = "H:|"
        var views = [String: UIView]()
        views["contentView"] = self.contentAddView
        
        for (index, view) in contentViews.enumerated() {
            
            let viewKey = "view_\(index)"
            views[viewKey] = view
            
            horizontalConstraints += "-5-[\(viewKey)]"
            
            contentScrollView.addConstraint(NSLayoutConstraint(item: view,
                                                               attribute: .height,
                                                               relatedBy: .equal,
                                                               toItem: contentScrollView,
                                                               attribute: .height,
                                                               multiplier: 1.0,
                                                               constant: -10.0))
            contentScrollView.addConstraint(NSLayoutConstraint(item: view,
                                                               attribute: .width,
                                                               relatedBy: .equal,
                                                               toItem: contentScrollView,
                                                               attribute: .height,
                                                               multiplier: 1.0,
                                                               constant: -10.0))
            
            
        }
        
        horizontalConstraints += "-5-[contentView]-5-|"
        contentConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: horizontalConstraints,
                                                                             options: NSLayoutFormatOptions.alignAllCenterY,
                                                                             metrics: nil,
                                                                             views: views))
        
        self.contentScrollView.addConstraints(self.contentConstraints)
        
        self.contentScrollView.setNeedsLayout()

        if animate {
            UIView.animate(withDuration: 0.5) {
                self.contentScrollView.layoutIfNeeded()
            }
            
        } else {
            self.contentScrollView.layoutIfNeeded()
        }
    }
    
    func addImages(_ images: [UIImage]) {
        
        for image in images {
            self.addImage(image, animate: false)
        }
    }
}


protocol ImageSlideBoardViewDelegate: class {
    
    func addImage()
}
