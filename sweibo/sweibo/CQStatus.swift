//
//  CQStatus.swift
//  sweibo
//
//  Created by y on 15/11/21.
//  Copyright © 2015年 y. All rights reserved.
//

class CQStatus: NSObject {
    // 微博创建时间
    var created_at:NSString?
    // 微博ID
    var idstr:NSString?
    // 微博内容
    var text:NSString?
    // 微博来源
    var source:NSString?
    // 转发
    var reposts_count:Int?
    // 评论
    var comments_count:Int?
    // 赞
    var attitudes_count:Int?
    // 配图数组
    var pic_urls: NSArray?
    // 用户
    var user:CQUser?
    // 转发微博
    var retweeted_status:CQStatus?
    static func getStatus(dic:NSDictionary) -> CQStatus {
        let status:CQStatus = CQStatus()
        if dic.count == 0 {
            return status
        }
        // 微博创建时间
        let fmt = NSDateFormatter()
        fmt.dateFormat = "EEE MMM d HH:mm:ss Z yyyy"
        let time:NSDate = fmt.dateFromString(dic["created_at"] as!
            String)!
        status.created_at = time.prettyDateWithReference(NSDate.init(timeIntervalSinceNow: 0))
        // 微博ID
        status.idstr = dic["idstr"] as? NSString
        // 微博内容
        status.text = dic["text"] as? NSString
        // 微博来源
        let source:NSString = (dic["source"] as? NSString)!
        let rstart = source.rangeOfString("\">")
        let rend = source.rangeOfString("</a>")
        if rstart.length > 0 {
            status.source = source.substringWithRange(NSRange.init(location: rstart.location + 2, length: rend.location - rstart.location - 2))
        }
        // 转发
        status.reposts_count = (dic["reposts_count"] as? Int)!
        // 评论
        status.comments_count = (dic["comments_count"] as? Int)!
        // 赞
        status.attitudes_count = (dic["attitudes_count"] as? Int)!
        // 配图数组
        let urls:NSMutableArray = NSMutableArray()
        for url in (dic["pic_urls"] as? NSArray)! {
            urls.addObject(CQPhoto.getPhoto(url as! NSDictionary))
        }
        status.pic_urls = urls
        // 用户
        status.user = CQUser.getUser(dic["user"] as! NSDictionary)
        // 转发微博
        if dic["retweeted_status"] != nil {
            status.retweeted_status = CQStatus.getStatus(dic["retweeted_status"] as! NSDictionary)
        }
        return status
    }
}
