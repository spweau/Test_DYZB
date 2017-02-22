//
//  PageContainView.swift
//  Test_DYZB
//
//  Created by Spweau on 2017/2/22.
//  Copyright © 2017年 sp. All rights reserved.
//

import UIKit

private let ContentCellID = "ContentCellID"

class PageContainView: UIView {
 
    // mark : 定义属性
    fileprivate var childVcs : [UIViewController]
    fileprivate var paretentViewController  : UIViewController
    
    // 懒加载 属性
    fileprivate lazy var collectionView : UICollectionView = {
        
        // 1. 创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        // 2. 创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect(origin: CGPoint(x:0,y:0), size: CGSize(width: 0, height: 0)), collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        //  注册cell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID )
        
        return collectionView
    }()
    
    
    // mark : 自定义构造函数
    init(frame: CGRect , childVcs : [UIViewController] , paretentViewController : UIViewController) {
        
        // 保存控制器
        print("childVcs.count = \(childVcs.count)")
        self.childVcs = childVcs
        self.paretentViewController = paretentViewController
        
        super.init(frame:frame)
        
        // 设置UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// mark - 设置UI界面
extension PageContainView {

    fileprivate func setupUI () {
    
        // 1. 将所有的自控制器添加到父控制器中
        for childVc in childVcs {
        
            paretentViewController.addChildViewController(childVc)
        }
        
        // 2. 添加UIcollectionView , 用于在cell中存放控制器的view
        addSubview(collectionView)
        collectionView.frame = bounds
    
    }




}


// mark - 遵守UIcollectionView  的 dataSource
extension PageContainView : UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print("childVcs.count = \(childVcs.count)")
        
        return childVcs.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // 1. 创建 cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        // 2. 给cell 设置内容
        
        for view in cell.contentView.subviews {
        
            view.removeFromSuperview()
        }
        
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
    



}

