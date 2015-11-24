//
//  CQUnread.swift
//  sweibo
//
//  Created by y on 15/11/22.
//  Copyright © 2015年 y. All rights reserved.
//

import UIKit
/**
返回值字段	字段类型	字段说明
status	int	新微博未读数
follower	int	新粉丝数
cmt	int	新评论数
dm	int	新私信数
mention_status	int	新提及我的微博数
mention_cmt	int	新提及我的评论数
group	int	微群消息未读数
private_group	int	私有微群消息未读数
notice	int	新通知未读数
invite	int	新邀请未读数
badge	int	新勋章数
photo	int	相册消息未读数
msgbox	int	{{{3}}}
*/
class CQUnread: NSObject {
    var status:Int=0
    var follower:Int=0
    var cmt:Int=0
    var dm:Int=0
    var mention_status:Int=0
    var mention_cmt:Int=0
    static func getUnread(dic:NSDictionary) -> CQUnread {
        let notice:CQUnread = CQUnread()
        notice.status = dic["status"] as! Int
        notice.follower = dic["follower"] as! Int
        notice.cmt = dic["cmt"] as! Int
        notice.dm = dic["dm"] as! Int
        notice.mention_status = dic["mention_status"] as! Int
        notice.mention_cmt = dic["mention_cmt"] as! Int
        return notice
    }
    func getMessageCount() -> Int{
        return cmt + dm + mention_cmt + mention_status
    }
    func getTotalCount() -> Int{
        return self.getMessageCount() + status + follower
    }
}
