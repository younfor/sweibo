//
//  CQUser.swift
//  sweibo
//
//  Created by y on 15/11/21.
//  Copyright © 2015年 y. All rights reserved.
//
class CQUser: NSObject {
    // 昵称
    var name:NSString?
    // 微博头像
    var profile_image_url:NSURL?
    // vip
    var mbtype:Int=0
    // 会员等级
    var mbrank:Int=0
    static func getUser(dic:NSDictionary) -> CQUser {
        let user:CQUser = CQUser()
        user.name = dic["name"] as? NSString
        user.profile_image_url = NSURL.init(string: dic["profile_image_url"]  as! String)
        user.mbtype = dic["mbtype"] as! Int
        user.mbrank = dic["mbrank"] as! Int
        return user
    }
    func isVip() -> Bool {
        return mbtype > 2
    }
}
