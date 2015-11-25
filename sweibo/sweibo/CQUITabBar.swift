//
//  CQUITabBar.swift
//  sweibo
//
//  Created by y on 15/11/15.
//  Copyright © 2015年 y. All rights reserved.
//

import UIKit

class CQUITabBar: UITabBar {

    override func layoutSubviews() {
        super.layoutSubviews()
        let w = Float(self.bounds.size.width);
        let h = Float(self.bounds.size.height);
        
        var btnX: Float = 0;
        let btnY = 0;
        let btnW = w / (Float(self.items!.count) + 1.0);
        let btnH = Float(self.bounds.size.height);
        var i = 0
        // 统一设置颜色
        for item in self.items! {
            item.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.orangeColor()], forState: UIControlState.Selected)
            
        }
        // 统一设置已经添加的控件位置
        for myview in self.subviews {
            if myview .isKindOfClass(NSClassFromString("UITabBarButton")!) {
                if i == 2 {
                    i = 3
                }
                btnX = Float(i) * btnW
                
                myview.frame = CGRectMake(CGFloat(btnX), CGFloat(btnY), CGFloat(btnW), CGFloat(btnH))
                i++
            }
        }
        // 添加自定义控件 - 中间的加号
        let btn = UIButton.init()
        btn.setImage(UIImage.init(named: "tabbar_compose_icon_add"), forState: UIControlState.Normal)
        btn.setImage(UIImage.init(named: "tabbar_compose_background_icon_add"), forState: UIControlState.Highlighted)
        btn.setBackgroundImage(UIImage.init(named: "tabbar_compose_button"), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage.init(named: "tabbar_compose_button_highlighted"), forState: UIControlState.Highlighted)
        btn.sizeToFit()
        self.addSubview(btn)
        btn.center = CGPointMake(CGFloat(w / 2), CGFloat(h / 2))
        // 设置事件
        btn.addTarget(self, action: "send", forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    // 发送新微博
    func send() {
        print("发送微博")
        let story:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let nav:UINavigationController = story.instantiateViewControllerWithIdentifier("sendNavigation") as! UINavigationController
        let win:UIWindow = UIApplication.sharedApplication().keyWindow!
        let controller:UIViewController = win.rootViewController!
        controller.presentViewController(nav, animated: true, completion: nil)
    }

}
