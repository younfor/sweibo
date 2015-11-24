//
//  CQCollectionViewCell.swift
//  sweibo
//
//  Created by y on 15/11/17.
//  Copyright © 2015年 y. All rights reserved.
//

import UIKit

class CQCollectionViewCell: UICollectionViewCell {
    var imgView:UIImageView?
    var shareBtn:UIButton?
    var startBtn:UIButton?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.imgView = UIImageView.init(frame: self.bounds)
        self.contentView.addSubview(self.imgView!)
        self.setBtn()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    // 增加分享按钮，登陆按钮
    func setBtn() {
        let shareBtn = UIButton.init(type: UIButtonType.Custom)
        shareBtn.setTitle("分享给大家", forState: UIControlState.Normal)
        shareBtn.setImage(UIImage.init(named: "new_feature_share_false"), forState: UIControlState.Normal)
        shareBtn.setImage(UIImage.init(named: "new_feature_share_true"), forState: UIControlState.Highlighted)
        shareBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        shareBtn.sizeToFit()
        let startBtn = UIButton.init(type: UIButtonType.Custom)
        startBtn.setTitle("开始微博", forState: UIControlState.Normal)
        startBtn.setBackgroundImage(UIImage.init(named: "new_feature_finish_button"), forState: UIControlState.Normal)
        startBtn.setBackgroundImage(UIImage.init(named: "new_feature_finish_button_highlighted"), forState: UIControlState.Highlighted)
        startBtn.sizeToFit()
        startBtn.addTarget(self, action: Selector.init("onFinish"), forControlEvents: UIControlEvents.TouchUpInside)
        // 分享按钮
        shareBtn.center = CGPointMake(self.frame.width * 0.5, self.frame.height * 0.8);
        // 开始按钮
        startBtn.center = CGPointMake(self.frame.width * 0.5, self.frame.height * 0.9);
        self.addSubview(shareBtn)
        self.addSubview(startBtn)
        self.shareBtn = shareBtn
        self.startBtn = startBtn
    }
    func onFinish() {
        // 检查是否注册
        let user = CQAccount.instance()
        if user == nil {
            // 登陆
            let loginVC = CQAuthViewController()
            self.window!.rootViewController = loginVC
            self.window?.makeKeyAndVisible()
        } else {
            let story = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = story.instantiateInitialViewController()
            self.window!.rootViewController = vc
        }
        
    }
    func setImg(index index:Int) {
        let name = "new_feature_"+String(index+1)
        self.imgView?.image = UIImage.init(named:name)
        if index == 3 {
            self.startBtn?.hidden = false
            self.shareBtn?.hidden = false
        } else {
            self.startBtn?.hidden = true
            self.shareBtn?.hidden = true
        }
    }

}
