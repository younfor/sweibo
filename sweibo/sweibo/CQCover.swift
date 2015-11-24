//
//  CQCover.swift
//  sweibo
//
//  Created by y on 15/11/16.
//  Copyright © 2015年 y. All rights reserved.
//

import UIKit
protocol CQCoverDelegate {
    func OnCoverClick()
}

class CQCover: UIView {

    var coverdelegate:CQCoverDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.blackColor()
        self.alpha = 0.1;
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.removeFromSuperview()
        //代理
        self.coverdelegate?.OnCoverClick()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    static func show() -> CQCover{
        let cover = CQCover.init(frame: UIScreen.mainScreen().bounds)
        (UIApplication.sharedApplication().keyWindow)!.addSubview(cover)
        return cover
        
    }
}
