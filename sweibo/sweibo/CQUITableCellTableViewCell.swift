//
//  CQUITableCellTableViewCell.swift
//  sweibo
//
//  Created by y on 15/11/23.
//  Copyright © 2015年 y. All rights reserved.
//

import UIKit

class CQUITableCellTableViewCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var vip: UIImageView!
    
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var source: UILabel!
    
    @IBOutlet weak var content: UILabel!
    
    @IBOutlet weak var retweet: UILabel!
    
    @IBOutlet weak var retweetBg: UIView!
    // 工具条
    @IBOutlet weak var retweetBtn: UIButton!
    
    @IBOutlet weak var commentBt: UIButton!
    
    @IBOutlet weak var goodBtn: UIButton!
    // 配图main
    @IBOutlet weak var picMain: UIView!
    
    @IBOutlet weak var picMainHeightConstaint: NSLayoutConstraint!
    // 转发配图
    
    @IBOutlet weak var retweetHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var picRe: UIView!
    var status:CQStatus?
    var statusRE:CQStatus?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.picMain.translatesAutoresizingMaskIntoConstraints = false
        self.picRe.translatesAutoresizingMaskIntoConstraints = false
        // Initialization code
    }
    func updatePics(data:CQStatus) {
        self.status = data
        let margin:CGFloat = 8
        let cols = data.pic_urls?.count == 4 ? 2 : 3
        if data.pic_urls == nil || data.pic_urls?.count == 0 {
            return
        }
        
        var i:Int = 0
        let w:CGFloat = (UIScreen.mainScreen().bounds.width - (CGFloat)(cols+1) * margin ) / (CGFloat)(cols)
        let row = ((data.pic_urls?.count)! - 1) / cols + 1
        for photo in data.pic_urls! {
            let cq:CQPhoto = photo as! CQPhoto
            // 初始化图片
            // 初始化图片
            let pic:UIImageView = UIImageView()
            // 添加点按手势
            pic.tag = i
            pic.userInteractionEnabled = true
            let tap = UITapGestureRecognizer.init(target: self, action: "tapMain:")
            pic.addGestureRecognizer(tap)
            let x:CGFloat = margin + (CGFloat)(i % cols) * (margin + w)
            let y:CGFloat = margin + (CGFloat)((Int)(i / cols)) * (margin + w)
            pic.frame = CGRectMake(x , y, w, w)
            pic.sd_setImageWithURL(cq.thumbnail_pic!, placeholderImage: UIImage.init(named: "timeline_image_placeholder"))
            self.picMain.addSubview(pic)
            i += 1
        }
        // 计算约束高度
        self.picMainHeightConstaint.constant = (CGFloat)(row) * (margin + w)
    }
    func updateRePics(data:CQStatus) {
        self.statusRE = data
        let margin:CGFloat = 8
        let cols = data.pic_urls?.count == 4 ? 2 : 3
        if data.pic_urls == nil || data.pic_urls?.count == 0 {
            return
        }
        var i:Int = 0
        
        //print("有转发图")
        for photo in data.pic_urls! {
            let cq:CQPhoto = photo as! CQPhoto
            // 初始化图片
            let pic:UIImageView = UIImageView()
            // 添加点按手势
            pic.tag = i
            pic.userInteractionEnabled = true
            let tap = UITapGestureRecognizer.init(target: self, action: "tapRE:")
            pic.addGestureRecognizer(tap)
            let w:CGFloat = (UIScreen.mainScreen().bounds.width - (CGFloat)(cols+1) * margin ) / (CGFloat)(cols)
            let x:CGFloat = margin + (CGFloat)(i % cols) * (margin + w)
            let y:CGFloat = margin + (CGFloat)((Int)(i / cols)) * (margin + w)
            pic.frame = CGRectMake(x , y, w, w)
            pic.sd_setImageWithURL(cq.thumbnail_pic!, placeholderImage: UIImage.init(named: "timeline_image_placeholder"))
            self.picRe.addSubview(pic)
            i += 1
        }
        
    }
    func tapRE(tap:UITapGestureRecognizer) {
        self.tap(tap,urls: (self.statusRE?.pic_urls)!)
    }
    func tapMain(tap:UITapGestureRecognizer) {
        self.tap(tap,urls: (self.status?.pic_urls)!)
    }
    func tap(tap:UITapGestureRecognizer,urls:NSArray) {
        //点击
        print("点击")
        let tapView:UIImageView = tap.view as! UIImageView
        var i:Int32 = 0
        let arrM:NSMutableArray = NSMutableArray()
        for pp in (urls) {
            let photo:CQPhoto = pp as! CQPhoto
            let p:MJPhoto = MJPhoto()
            var urlStr:NSString = (photo.thumbnail_pic?.absoluteString.textToNSString())!
            urlStr = urlStr.stringByReplacingOccurrencesOfString("thumbnail", withString: "bmiddle")
            p.url = NSURL.init(string: urlStr as String)
            p.index = i
            p.srcImageView = tapView
            arrM.addObject(p)
            i++
        }
        // 弹出浏览器
        let brower = MJPhotoBrowser()
        brower.photos = arrM as [AnyObject]
        brower.currentPhotoIndex = (UInt)(tapView.tag)
        brower.show()
    }
    func updateDatas(data:CQStatus) {
        self.status = data
        // 先清空
        for v in self.picMain.subviews {
            v.removeFromSuperview()
        }
        // 先清空
        for v in self.picRe.subviews {
            v.removeFromSuperview()
        }
        // 配图转发
        //print(data.text)
        if data.retweeted_status != nil {
            self.updateRePics(data.retweeted_status!)
            // 取消主要图约束
            self.picMainHeightConstaint.constant = 5
        } else {
            // 配图
            self.updatePics(data)
        }
        //print("\(self.picMain.bounds) \(self.picRe.bounds)")
        
        // 头像
        self.icon.sd_setImageWithURL(data.user!.profile_image_url, placeholderImage: UIImage.init(named: "timeline_image_placeholder"))
        self.icon.layer.cornerRadius = 6;
        self.icon.layer.masksToBounds = true;
        // 昵称
        if (data.user?.isVip())! == 1 {
            self.name.textColor = UIColor.redColor()
        } else {
            self.name.textColor = UIColor.blackColor()
        }
        self.name.text = data.user?.name as? String
        // vip
        let vipname:String = "common_icon_membership_level\((data.user?.mbrank)!)"
        self.vip.image = UIImage.init(named: vipname)
        // 时间
        self.time.text = data.created_at as? String
        // 来源
        self.source.text = data.source as? String
        // 正文
        self.content.text = data.text as? String
        // 转发微博
        if data.retweeted_status != nil {
            self.retweet.text = data.retweeted_status?.text as? String
        } else {
            self.retweet.text = ""
        }
        self.setNeedsUpdateConstraints()
        // 工具条
        if data.reposts_count > 0 {
            self.retweetBtn.setTitle("\(data.reposts_count!)", forState: UIControlState.Normal)
        } else {
            self.retweetBtn.setTitle("转发", forState: UIControlState.Normal)
        }
        if data.comments_count > 0 {
            self.commentBt.setTitle("\(data.comments_count!)", forState: UIControlState.Normal)
        } else {
            self.commentBt.setTitle("评论", forState: UIControlState.Normal)
        }
        if data.attitudes_count > 0 {
            self.goodBtn.setTitle("\(data.attitudes_count!)", forState: UIControlState.Normal)
        } else {
            self.goodBtn.setTitle("赞", forState: UIControlState.Normal)
        }
        
    }
    
}
