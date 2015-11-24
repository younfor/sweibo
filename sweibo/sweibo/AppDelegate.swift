//
//  AppDelegate.swift
//  sweibo
//
//  Created by y on 15/11/13.
//  Copyright © 2015年 y. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // 注册通知
        let setting = UIUserNotificationSettings.init(forTypes: UIUserNotificationType.Badge, categories: nil)
        application.registerUserNotificationSettings(setting)
        // 新特性
        let infoDictionary = NSBundle.mainBundle().infoDictionary
        let currentVersion : AnyObject? = infoDictionary!["CFBundleVersion"] as! String
        //print(currentVersion!)
        NSUserDefaults.standardUserDefaults().setObject(currentVersion!, forKey: "version")
        let lastVersion = NSUserDefaults.standardUserDefaults().objectForKey("version")!
        // 手动启动程序 - - 欢迎界面
        if currentVersion as! String != lastVersion as! String{
            self.window = UIWindow.init(frame: UIScreen.mainScreen().bounds)
            let vc = CQCollectionViewController.instance()
            self.window!.rootViewController = vc
            self.window?.makeKeyAndVisible()
        }
        // 检查是否注册
        let user = CQAccount.instance()
        if user == nil {
            // 登陆
            let loginVC = CQAuthViewController()
            self.window!.rootViewController = loginVC
            self.window?.makeKeyAndVisible()
        }
        print("已登录")
        // 故事版 - - 主界面
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidReceiveMemoryWarning(application: UIApplication) {
        SDWebImageManager.sharedManager().cancelAll()
        SDWebImageManager.sharedManager().imageCache.clearMemory()
    }
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

