//
//  CQSendToolBar.swift
//  sweibo
//
//  Created by y on 15/11/25.
//  Copyright © 2015年 y. All rights reserved.
//

import UIKit

protocol CQSendToolBarDelegate {
    func openPic()
}
class CQSendToolBar: UIToolbar {

    var cqdelegate:CQSendToolBarDelegate?
    @IBAction func openPic(sender: AnyObject) {
        // 打开相册 - 代理
        self.cqdelegate?.openPic()
    }
    @IBAction func closeKeyBoard(sender: AnyObject) {
        self.superview!.endEditing(true)
        //print("a")
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
