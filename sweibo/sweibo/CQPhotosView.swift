//
//  CQPhotosView.swift
//  sweibo
//
//  Created by y on 15/11/25.
//  Copyright © 2015年 y. All rights reserved.
//

import UIKit

class CQPhotosView: UIView {

    var image:UIImage?
    
    func addImage(image:UIImage) {
        self.image = image
        let imageView = UIImageView()
        imageView.image = image
        self.addSubview(imageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let cols:CGFloat = 3
        let margin:CGFloat = 10
        let wh = (self.frame.width - (cols + 1) * margin ) / cols
        var x:CGFloat = 0
        var y:CGFloat = 0
        var col:Int = 0
        var row:Int = 0
        var i:Int = 0
        for ( i = 0; i < self.subviews.count ; i++) {
            let imagev = self.subviews[i]
            col = i % (Int)(cols)
            row = i / (Int)(cols)
            x = (CGFloat)(col)*(margin + wh)
            y = (CGFloat)(row)*(margin + wh)
            imagev.frame = CGRectMake(margin + x, y, wh, wh)
            
        }
    }

}
