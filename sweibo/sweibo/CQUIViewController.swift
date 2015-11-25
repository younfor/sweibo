//
//  CQUIViewController.swift
//  sweibo
//
//  Created by y on 15/11/25.
//  Copyright © 2015年 y. All rights reserved.
//

import UIKit

class CQUIViewController: UIViewController {
    
    
    @IBOutlet weak var sendBtn: UIBarButtonItem!
    var toolbar:CQSendToolBar?
    @IBAction func close(sender: AnyObject) {
        self.view.endEditing(true)
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func send(sender: AnyObject) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sendBtn.enabled = false
        self.automaticallyAdjustsScrollViewInsets = false
        let toolbar:CQSendToolBar = NSBundle.mainBundle().loadNibNamed("CQSendToolBar", owner: self, options: nil).last as! CQSendToolBar
        toolbar.frame = CGRectMake(0, self.view.frame.height - 35, self.view.frame.width, 35)
        self.toolbar = toolbar
        self.view.addSubview(toolbar)
        // 监听键盘弹出
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"onKeyBoard:" , name: UIKeyboardWillChangeFrameNotification, object: nil)
    }
    func onKeyBoard(note:NSNotification) {
        print(note.userInfo)
        let durtion = note.userInfo![UIKeyboardAnimationDurationUserInfoKey]?.floatValue
        let f = note.userInfo![UIKeyboardFrameEndUserInfoKey]?.CGRectValue
        if f?.origin.y == self.view.frame.height {
            // 没有弹出键盘
            UIView.animateWithDuration((NSTimeInterval)(durtion!), animations: {
                self.toolbar!.transform = CGAffineTransformIdentity
            })
        } else {
            UIView.animateWithDuration((NSTimeInterval)(durtion!), animations: {                self.toolbar!.transform = CGAffineTransformMakeTranslation(0, -f!.size.height);
            })
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
