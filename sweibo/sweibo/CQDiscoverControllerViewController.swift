//
//  CQDiscoverControllerViewController.swift
//  sweibo
//
//  Created by y on 15/11/16.
//  Copyright © 2015年 y. All rights reserved.
//

import UIKit

class CQDiscoverControllerViewController: UIViewController,UITableViewDataSource {
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.dataSource = self
        self.tableview.rowHeight = 60
        // 去除空白scrollview
        self.automaticallyAdjustsScrollViewInsets = false
        // Do any additional setup after loading the view.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("discoverCell")!
        cell.textLabel!.text = "哈哈哈"
        //print(cell)
        return cell
    }


}
