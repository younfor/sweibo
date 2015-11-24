//
//  CQPopMenu.swift
//  sweibo
//
//  Created by y on 15/11/16.
//  Copyright © 2015年 y. All rights reserved.
//

import UIKit

class CQPopMenu: UIImageView {

    var contentView:UIView?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView = UIView.init(frame: frame)
        self.contentView!.backgroundColor = UIColor.orangeColor()
        self.addSubview(self.contentView!)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let y:CGFloat = 40
        let margin:CGFloat = 20
        let x:CGFloat = margin
        let w:CGFloat = self.frame.width - 2 * margin
        let h:CGFloat = self.frame.height - y - margin
        self.contentView!.frame = CGRectMake(x, y, w, h)
        
    }
    static func show(rect:CGRect) -> CQPopMenu {
        let menu = CQPopMenu.init(frame: rect)
        UIApplication.sharedApplication().keyWindow!.addSubview(menu)
        menu.userInteractionEnabled = true
        let img = UIImage(named: "popover_background")!.resizableImageWithCapInsets(UIEdgeInsets(top: 20 ,left: 50,bottom:20,right: 50))
        menu.image = img
        return menu
    }
    
    func hide() {
        self.removeFromSuperview()
    }

}
