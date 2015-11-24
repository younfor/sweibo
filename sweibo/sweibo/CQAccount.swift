//
//  CQAccount.swift
//  sweibo
//
//  Created by y on 15/11/19.
//  Copyright © 2015年 y. All rights reserved.
//

class CQAccount: NSObject,NSCoding {
    var access_token:NSString?
    var expires_in:NSString?
    var uid:NSString?
    var expires_date:NSDate? //过期时间=当前时间+有效期
    var remind_in:NSString? //当前有效期
    static let filename = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory , NSSearchPathDomainMask.UserDomainMask, true)[0].stringByAppendingString("/account.data")
    static var ins:CQAccount?
    // 归档
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.access_token, forKey: "access_token")
        aCoder.encodeObject(self.expires_date, forKey: "expires_date")
        aCoder.encodeObject(self.expires_in, forKey: "expires_in")
        aCoder.encodeObject(self.uid, forKey: "uid")
        aCoder.encodeObject(self.remind_in, forKey: "remind_in")
    }
    
    override init() {
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.access_token = aDecoder.decodeObjectForKey("access_token") as? NSString
        self.expires_date = aDecoder.decodeObjectForKey("expires_date") as? NSDate
        self.expires_in = aDecoder.decodeObjectForKey("expires_in") as? NSString
        self.uid = aDecoder.decodeObjectForKey("uid") as? NSString
        self.remind_in = aDecoder.decodeObjectForKey("remind_in") as? NSString
    }
    
    static func initWithDic(dic:NSDictionary) -> CQAccount{
        let account = CQAccount()
        account.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
        // 设置过期时间
        account.expires_date = NSDate.init(timeIntervalSinceNow: (account.expires_in?.doubleValue)!)
        //print(account.expires_date)
        return account
    }
    // 沙盒存储
    func save() {
        //print(CQAccount.filename)
        NSKeyedArchiver.archiveRootObject(self, toFile: CQAccount.filename)
    }
    
    // 单例
    static func instance() -> CQAccount? {
        if CQAccount.ins == nil {
            CQAccount.ins = NSKeyedUnarchiver.unarchiveObjectWithFile(CQAccount.filename) as? CQAccount
            let account:CQAccount = CQAccount.ins!
            //print(NSDate())
            //print(account.expires_date)
            if NSDate().compare(account.expires_date!) != NSComparisonResult.OrderedAscending {
                return nil
            }
        }
        return CQAccount.ins!
    }

}
