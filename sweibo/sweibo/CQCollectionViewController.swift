//
//  CQCollectionViewController.swift
//  sweibo
//
//  Created by y on 15/11/17.
//  Copyright © 2015年 y. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CQCollectionViewController: UICollectionViewController {
    
    weak var pageControl:UIPageControl?
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    static func instance() -> CQCollectionViewController {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = UIScreen.mainScreen().bounds.size
        // 清空行距
        layout.minimumLineSpacing = 0;
        // 滚动方向
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        let controller = super.init(collectionViewLayout: layout)
        return controller as! CQCollectionViewController
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.pagingEnabled = true
        self.collectionView?.showsHorizontalScrollIndicator = false
        self.collectionView!.registerClass(CQCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        // 小圆点
        let pageControl = UIPageControl.init()
        pageControl.numberOfPages = 4
        pageControl.pageIndicatorTintColor = UIColor.blackColor()
        pageControl.currentPageIndicatorTintColor = UIColor.orangeColor()
        pageControl.center = CGPointMake(self.view.frame.width * 0.5, self.view.frame.height - 20);
        self.pageControl = pageControl
        self.view.addSubview(pageControl)
        
    }
    // scroll
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / self.view.frame.width + 0.5
        self.pageControl?.currentPage = Int(page)
        //print(page)
    }
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
         return 1
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CQCollectionViewCell
        cell.setImg(index: indexPath.row)
        return cell
    }

    
}
