//
//  CQTextView.swift
//  sweibo
//
//  Created by y on 15/11/25.
//  Copyright © 2015年 y. All rights reserved.
//

import UIKit

class CQTextView: UITextView,UITextViewDelegate {

    lazy var placeholder:UILabel = UILabel()
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("初始化text")
        self.becomeFirstResponder()
        self.editable = true
        self.alwaysBounceVertical = true
        self.placeholder.text = "写几个字发发吧!"
        self.placeholder.font = UIFont.systemFontOfSize(14)
        self.placeholder.sizeToFit()
        self.placeholder.frame = CGRectMake(5, 7,self.placeholder.frame.width,self.placeholder.frame.height)
        self.addSubview(self.placeholder)
        self.delegate = self
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textChange", name: UITextViewTextDidChangeNotification, object: nil)

    }
    func textChange() {
        print("通知键盘")
        self.placeholder.hidden = true
    }
    override func shouldChangeTextInRange(range: UITextRange, replacementText text: String) -> Bool {
        print("hehlo")
        return true
    }
    
}
