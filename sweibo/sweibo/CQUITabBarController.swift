//
//  CQUITabBar.swift
//  sweibo
//
//  Created by y on 15/11/15.
//  Copyright © 2015年 y. All rights reserved.
//

import UIKit

class CQUITabBarController: UITabBarController {
  
    // 网络请求类
    lazy var cqnet: CQNet = CQNet()
    override func viewDidLoad() {
        // 利用KVC重载--自定义TabBar
        let tab = CQUITabBar();
        self.setValue(tab, forKey: "tabBar")
        NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "requestUnread", userInfo: nil, repeats: true)
        
    }
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        if self.selectedIndex == item.tag && item.tag == 0 {
            NSNotificationCenter.defaultCenter().postNotification(NSNotification.init(name: "UPDATEHOMEUNREAD", object: nil))
        }
    }
    
    func requestUnread() {
        cqnet.getLatesUnread(
            [:]) { (data) -> Void in
                let unread:CQUnread = data as! CQUnread
                let home:UITabBarItem = self.tabBar.items![0]
                let message:UITabBarItem = self.tabBar.items![1]
                let profile:UITabBarItem = self.tabBar.items![3]
                if unread.status > 0 {
                    home.badgeValue = (String)(unread.status)
                }
                if unread.getMessageCount() > 0 {
                    message.badgeValue = (String)(unread.getMessageCount())
                }
                if unread.follower > 0 {
                    profile.badgeValue = (String)(unread.follower)
                }
                UIApplication.sharedApplication().applicationIconBadgeNumber = unread.getTotalCount()
        }
    }
}
