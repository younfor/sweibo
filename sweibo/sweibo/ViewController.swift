//
//  ViewController.swift
//  sweibo
//
//  Created by y on 15/11/13.
//  Copyright © 2015年 y. All rights reserved.
//

import UIKit

class ViewController: UITableViewController,CQCoverDelegate{

    @IBOutlet weak var mytitle: CQTitleButton!
    var popmenu:CQPopMenu?
    // 网络请求类
    lazy var cqnet: CQNet = CQNet()
    var datas:NSMutableArray = NSMutableArray()
    var frames:NSMutableArray = NSMutableArray()

    @IBAction func pop(sender: AnyObject) {
        // 测试滑动
        let one = CQOneViewController.init(nibName: nil, bundle: nil)
        self.navigationController?.hidesBottomBarWhenPushed = true
        self.tabBarController?.tabBar.hidden = true
        self.navigationController!.pushViewController(one, animated: true)
    }
    @IBAction func titleBtn(sender: AnyObject) {
        self.mytitle.selected = !self.mytitle.selected
        // cover
        let cover = CQCover.show()
        cover.coverdelegate = self
        // pop
        
        let w:CGFloat = 210
        let h = w
        let x = UIScreen.mainScreen().bounds.size.width / 2 -
            w / 2
        let y = CGRectGetMaxY(self.mytitle.frame) + 10
        //print(x,y,w,h)
        self.popmenu = CQPopMenu.show(CGRectMake(x, y, w, h))
    }
    // 代理
    func OnCoverClick() {
        // 隐藏pop
        self.popmenu!.hide()
        self.mytitle.selected = !self.mytitle.selected
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.addHeaderWithCallback { () -> Void in
            self.loadNewStatus()
        }
        self.tableView.addFooterWithCallback { () -> Void in
            self.loadOldStatus()
        }
        self.tableView.headerBeginRefreshing()
        // 注册通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateUnread", name: "UPDATEHOMEUNREAD", object: nil)
        // 注册cell
        self.tableView.registerNib(UINib(nibName: "CQUITableCellTableViewCell", bundle:nil), forCellReuseIdentifier: "homecell")
        
    }
    // 更新未读消息
    func updateUnread() {
        self.tableView.headerBeginRefreshing()
    }
    // 加载旧的微博
    func loadOldStatus() {
        // 获取旧的微博
        var params:[String:AnyObject] = [String:AnyObject]()
        if (self.datas.count > 0) {
            let user:CQStatus = self.datas[self.datas.count - 1] as! CQStatus
            let maxID = (user.idstr?.longLongValue)! - 1
            params["max_id"] = NSString.init(format: "%ld", maxID)
            print(params["max_id"])
        }
        cqnet.getLatestWeibo(params, onSuccess: { (data) -> Void in
            let datas:[AnyObject] = data as! [AnyObject]
            self.datas.addObjectsFromArray(datas)
            // 更新frame
            self.frames.removeAllObjects()
            for status in self.datas {
                self.frames.addObject(CQFrame().setFrames(status as! CQStatus))
            }
            self.tableView.footerEndRefreshing()
            self.tableView.reloadData()
            },onFail:{
                self.tableView.footerEndRefreshing()
        }
        )
    }
    // 加载新微博
    func loadNewStatus() {
        // 获取最新微博
        self.tableView.headerEndRefreshing()
        var params:[String:AnyObject] = [String:AnyObject]()
        if (self.datas.count > 0) {
            let user:CQStatus = self.datas[0] as! CQStatus
            params["since_id"] = user.idstr
            print(user.idstr)
        }
        cqnet.getLatestWeibo(params, onSuccess: { (data) -> Void in
            let datas:[AnyObject] = data as! [AnyObject]
            // 最新微博tips
            self.showNewStatusTips(datas.count)
            self.datas.insertObjects(datas, atIndexes: NSIndexSet.init(indexesInRange: NSRange.init(location: 0, length: datas.count)))
            // 更新frame
            self.frames.removeAllObjects()
            for status in self.datas {
                self.frames.addObject(CQFrame().setFrames(status as! CQStatus))
            }
            self.tableView.headerEndRefreshing()
            self.tableView.reloadData()
            },onFail:{
                self.tableView.footerEndRefreshing()
            
        })
    }
    // 最新微博tips
    func showNewStatusTips(num:Int) {
        if num == 0 {
            return
        }
        let w = self.view.frame.width
        let h:CGFloat = 35
        let x:CGFloat = 0
        let y = CGRectGetMaxY((self.navigationController?.navigationBar.frame)!)
        let tips = UILabel.init(frame: CGRectMake(x, y, w, h))
        self.navigationController?.view.insertSubview(tips, belowSubview: (self.navigationController?.navigationBar)!)
        tips.backgroundColor = UIColor.init(patternImage: UIImage.init(named: "timeline_new_status_background")!)
        tips.text = "最新微博有\(num)条"
        tips.textColor = UIColor.whiteColor()
        tips.textAlignment = NSTextAlignment.Center
        UIView.animateWithDuration (1, delay: 1, options: UIViewAnimationOptions.CurveLinear ,animations: {
            tips.transform = CGAffineTransformMakeTranslation(0, -h)
            
            }, completion: { (value:Bool) -> Void in
                tips.removeFromSuperview()
        })

    }
    // tableviewcell
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datas.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : CQUITableCellTableViewCell = tableView.dequeueReusableCellWithIdentifier("homecell", forIndexPath: indexPath) as! CQUITableCellTableViewCell
        let data:CQStatus = self.datas.objectAtIndex(indexPath.row) as! CQStatus
        cell.updateDatas(data)
        cell.selectionStyle = UITableViewCellSelectionStyle.None;

        return cell
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let frame:CQFrame = self.frames[indexPath.row] as! CQFrame
        return frame.getRowHeight()
    }
    
}

