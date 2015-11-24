//
//  CQString.swift
//  sweibo
//
//  Created by y on 15/11/23.
//  Copyright © 2015年 y. All rights reserved.
//

import UIKit
extension String {
    func textToNSString() -> NSString{
        let text1: NSString = NSString(CString: (self.cStringUsingEncoding(NSUTF8StringEncoding))!,
            encoding: NSUTF8StringEncoding)!
        return text1
    }
}

extension NSString {
    func textSizeWithFont(font: UIFont, constrainedToSize size:CGSize) -> CGSize {
        var textSize:CGSize!
        if CGSizeEqualToSize(size, CGSizeZero) {
            let attributes = NSDictionary(object: font, forKey: NSFontAttributeName)
            textSize = self.sizeWithAttributes(attributes as? [String : AnyObject])
        } else {
            let option = NSStringDrawingOptions.UsesLineFragmentOrigin
            let attributes = NSDictionary(object: font, forKey: NSFontAttributeName)
            let stringRect = self.boundingRectWithSize(size, options: option, attributes: attributes as? [String : AnyObject], context: nil)
            textSize = stringRect.size
        }
        return textSize
    }
}