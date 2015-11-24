//
//  CQTitleButton.swift
//  sweibo
//
//  Created by y on 15/11/16.
//  Copyright © 2015年 y. All rights reserved.
//

import UIKit

class CQTitleButton: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.setBackgroundImage(UIImage.init(named:"navigationbar_filter_background_highlighted" ), forState: UIControlState.Highlighted)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.titleLabel?.frame.origin.x = 0
        self.imageView?.frame.origin.x = CGRectGetMaxX((self.titleLabel?.frame)!)
    }
    
    override func setTitle(title: String?, forState state: UIControlState) {
        super.setTitle(title, forState: state)
        self.sizeToFit()
    }
    
    override func setImage(image: UIImage?, forState state: UIControlState) {
        super.setImage(image, forState: state)
        self.sizeToFit()
        
    }
    
    override func setBackgroundImage(image: UIImage?, forState state: UIControlState) {
        super.setBackgroundImage(image, forState: state)
        self.sizeToFit()
    }

}
