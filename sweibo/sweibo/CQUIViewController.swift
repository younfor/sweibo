//
//  CQUIViewController.swift
//  sweibo
//
//  Created by y on 15/11/25.
//  Copyright © 2015年 y. All rights reserved.
//

import UIKit

class CQUIViewController: UIViewController,CQSendToolBarDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    @IBOutlet weak var textView: CQTextView!
    @IBOutlet weak var sendBtn: UIBarButtonItem!
    // 网络
    lazy var cqnet = CQNet()
    // 底部工具条
    var toolbar:CQSendToolBar?
    // 相册图
    lazy var photoImages:NSMutableArray = NSMutableArray()
    var photosView:CQPhotosView?
    @IBAction func close(sender: AnyObject) {
        self.view.endEditing(true)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    // 发送微博
    @IBAction func send(sender: AnyObject) {
        let text = self.textView.text + " @by iosApp"
        MBProgressHUD.showLoading(self.view)
        // 文字
        if self.photoImages.count == 0 {
            
            self.cqnet.sendWeibo(["status":text as NSString], onSuccess: { () -> Void in
                MBProgressHUD.hide(self.view)
                self.dismissViewControllerAnimated(true, completion: nil)
            })
        } else {
        // 图片
            let sendImg = self.photoImages[0] as! UIImage
            let data = UIImagePNGRepresentation(sendImg)!
            //print(data.length)
            self.cqnet.sendPicText(["status":text as NSString,"pic":data], onSuccess: { () -> Void in
                MBProgressHUD.hide(self.view)
                 self.dismissViewControllerAnimated(true, completion: nil)
            })
        }
        self.photoImages.removeAllObjects()
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
        // toolbar代理
        self.toolbar?.cqdelegate = self
        // 相册图
        self.photosView = CQPhotosView()
        self.photosView?.frame = CGRectMake(0, 70, self.view.frame.width, self.view.frame.height - 70)
        self.textView.addSubview(self.photosView!)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textChange", name: UITextViewTextDidChangeNotification, object: nil)
    }
    // 键盘监听
    func textChange() {
        print("显示发送")
        self.sendBtn.enabled = true
    }
    // 代理
    func openPic() {
        print("打开相册")
        let picker = UIImagePickerController()
        picker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
        picker.delegate = self
        self.presentViewController(picker, animated: true, completion: nil)
    }
    // 相册打开代理
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage]
        self.photoImages.addObject(image!)
        self.photosView?.addImage(image! as! UIImage)
        self.sendBtn.enabled = true
        
    }
    func onKeyBoard(note:NSNotification) {
        //print(note.userInfo)
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
   
}
