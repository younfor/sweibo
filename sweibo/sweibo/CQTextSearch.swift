//
//  CQTextSearch.swift
//  sweibo
//
//  Created by y on 15/11/16.
//  Copyright © 2015年 y. All rights reserved.
//

import UIKit

class CQTextSearch: UITextField {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.font = UIFont.systemFontOfSize(13)
        // 可伸缩
        let img = UIImage.init(named: "searchbar_textfield_background")!
        //img.stretchableImageWithLeftCapWidth(NSInteger(img.size.width * 0.5), topCapHeight: NSInteger(img.size.height * 0.5))
        self.background = img
        let leftImg = UIImage.init(named: "searchbar_textfield_search_icon")!
        let leftImgView = UIImageView.init(image: leftImg)
        leftImgView.bounds = CGRectMake(0, 0, leftImgView.bounds.width + 10, leftImgView.bounds.height)
        leftImgView.contentMode = UIViewContentMode.Center
        self.leftView = leftImgView
        self.leftViewMode = UITextFieldViewMode.Always
    }

}
