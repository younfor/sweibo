//
//  CQNet.swift
//  sweibo
//
//  Created by y on 15/11/21.
//  Copyright © 2015年 y. All rights reserved.
//
import Alamofire

class CQNet: NSObject {
    // 获取最新微博url
    let latestWeibo = "https://api.weibo.com/2/statuses/friends_timeline.json"
    // 获取最新未读
    let latestUnread = "https://rm.api.weibo.com/2/remind/unread_count.json"
    // 发送微博文字
    let sendWeibo = "https://api.weibo.com/2/statuses/update.json"
    // 发送图片文字
    let sendPic = "https://upload.api.weibo.com/2/statuses/upload.json"
    lazy var token:AnyObject = (CQAccount.instance()?.access_token)!
    lazy var uid:AnyObject = (CQAccount.instance()?.uid)!
    // 构造器
    // 发送图片文字
    
    func sendPicText(var params:[String : AnyObject], onSuccess:() -> Void) {
        params["access_token"] = self.token
        let token:NSString = self.token as! NSString
        let status:NSString = params["status"] as! NSString
        Alamofire.upload(.POST, self.sendPic, multipartFormData: {
            multipartFormData in
            let mul:MultipartFormData = multipartFormData
            mul.appendBodyPart(data: params["pic"] as! NSData, name: "pic")
            mul.appendBodyPart(data: token.dataUsingEncoding(NSUTF8StringEncoding)!, name: "access_token")
            mul.appendBodyPart(data: status.dataUsingEncoding(NSUTF8StringEncoding)! , name: "status")
            
            }, encodingCompletion: {
                encodingResult in
                print(encodingResult)
                onSuccess()
            })
    }
    // 发送微博文字
    func sendWeibo(var params:[String : AnyObject], onSuccess:() -> Void) {
        params["access_token"] = self.token
        Alamofire.request(.POST, self.sendWeibo,parameters: params).responseJSON { (res :Response<AnyObject, NSError>) -> Void in
            let s = NSString.init(data: res.data!, encoding: NSUTF8StringEncoding)
            print(s)
            onSuccess()
        }
    }
    // 最新未读消息
    func getLatesUnread(var params:[String : AnyObject], onSuccess:(data:AnyObject) -> Void) {
        params["access_token"] = self.token
        params["uid"] = self.uid
        Alamofire.request(.GET, self.latestUnread,parameters: params).responseJSON { (res :Response<AnyObject, NSError>) -> Void in
            do {
                var js:AnyObject?;
                try js = NSJSONSerialization.JSONObjectWithData(res.data!, options: NSJSONReadingOptions.AllowFragments)
                let datas:CQUnread = CQUnread.getUnread(js as! NSDictionary)
                onSuccess(data: datas)
            } catch {
                print(error)
            }
            
            //onSuccess(data: res.data!)
        }

    }
    // 获取最新微博
    func getLatestWeibo(var params:[String : AnyObject], onSuccess:(data:AnyObject) -> Void,onFail:() -> Void) {
        params["access_token"] = self.token
        Alamofire.request(.GET, self.latestWeibo,parameters: params).responseJSON { (res :Response<AnyObject, NSError>) -> Void in
            //res.data?.writeToFile("/Users/y/Desktop/data.json", atomically: true)
            //let s = NSString.init(data: res.data!, encoding: NSUTF8StringEncoding)
            do {
                var js:AnyObject?;
                try js = NSJSONSerialization.JSONObjectWithData(res.data!, options: NSJSONReadingOptions.AllowFragments)
                let dataArray: NSArray = js?.objectForKey("statuses")! as! NSArray
                let datas:NSMutableArray = NSMutableArray()
                for dict in dataArray {
                    
                    let dic: NSDictionary = dict as! NSDictionary
                    // 字典转模型
                    let status:CQStatus = CQStatus.getStatus(dic)
                    datas.addObject(status)
                }
                onSuccess(data: datas)
            } catch {
                print(error)
                onFail()
            }

            //onSuccess(data: res.data!)
        }
    }
}
