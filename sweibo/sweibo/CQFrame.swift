//
//  CQFrame.swift
//  sweibo
//
//  Created by y on 15/11/23.
//  Copyright © 2015年 y. All rights reserved.
//

import UIKit

class CQFrame: NSObject {
    
    // 主要内容
    var heightMain:CGFloat=0
    // 转发内容
    var heightReteet:CGFloat=0
    // 主要图片
    var heightMainPic:CGFloat=0
    // 转发图片
    var heightRePic:CGFloat=0
    // 计算Frame
    func setFrames(status:CQStatus) -> CQFrame {
        let margin:CGFloat = 8
        // 计算图片告诉
        if status.pic_urls != nil && status.pic_urls?.count > 0 {
            let cols = status.pic_urls?.count == 4 ? 2 : 3
            let row = ((status.pic_urls?.count)! - 1) / cols + 1
            let w:CGFloat = (UIScreen.mainScreen().bounds.width - (CGFloat)(cols+1) * margin ) / (CGFloat)(cols)
            self.heightMainPic = (CGFloat)(row) * (margin + w)
        }
        if status.retweeted_status != nil && status.retweeted_status?.pic_urls?.count > 0 {
            let cols = status.retweeted_status?.pic_urls?.count == 4 ? 2 : 3
            let row = ((status.retweeted_status?.pic_urls?.count)! - 1) / cols + 1
            let w:CGFloat = (UIScreen.mainScreen().bounds.width - (CGFloat)(cols+1) * margin ) / (CGFloat)(cols)
            self.heightRePic = (CGFloat)(row) * (margin + w)
        }
        //print("text: \(status.text)h1:\(self.heightMainPic) h2:\(self.heightRePic)")
        // retweet
        if status.retweeted_status != nil {
            let text1: NSString = NSString(CString: (status.retweeted_status?.text!.cStringUsingEncoding(NSUTF8StringEncoding))!,
                encoding: NSUTF8StringEncoding)!
            let contentSize1 = text1.textSizeWithFont(UIFont.systemFontOfSize(15) ,constrainedToSize: CGSizeMake(UIScreen.mainScreen().bounds.width-20, CGFloat.max))
            self.heightReteet = contentSize1.height
        } else {
            self.heightReteet = 0;
        }

        // main
        let text2: NSString = NSString(CString: (status.text!.cStringUsingEncoding(NSUTF8StringEncoding)),
            encoding: NSUTF8StringEncoding)!
        let contentSize2 = text2.textSizeWithFont(UIFont.systemFontOfSize(16) ,constrainedToSize: CGSizeMake(UIScreen.mainScreen().bounds.width, CGFloat.max))
        self.heightMain = contentSize2.height
 
        return self
    }
        // 计算行高
    func getRowHeight() -> CGFloat {
        return self.heightMain + self.heightReteet + 120 + self.heightMainPic + self.heightRePic
    }
}
