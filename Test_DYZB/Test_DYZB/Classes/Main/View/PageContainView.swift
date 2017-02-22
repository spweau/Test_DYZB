//
//  PageContainView.swift
//  Test_DYZB
//
//  Created by Spweau on 2017/2/22.
//  Copyright © 2017年 sp. All rights reserved.
//

import UIKit

protocol PageContainViewDelegate : class {
    
    func pageContainView(contentView : PageContainView , progress : CGFloat , sourceIndex : Int , targetIndex : Int)
    
}


private let ContentCellID = "ContentCellID"

class PageContainView: UIView {
 
    // mark : 定义属性
    fileprivate var childVcs : [UIViewController]
    fileprivate weak var paretentViewController  : UIViewController?
    fileprivate var startOffsetX : CGFloat = 0
    fileprivate var isForbidScrollDelegate : Bool = false
    // 添加代理
    weak var delegate : PageContainViewDelegate?
    
    // 懒加载 属性
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        
        // 1. 创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        // 2. 创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect(origin: CGPoint(x:0,y:0), size: CGSize(width: 0, height: 0)), collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        //  注册cell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID )
        
        return collectionView
    }()
    
    
    // mark : 自定义构造函数
    init(frame: CGRect , childVcs : [UIViewController] , paretentViewController : UIViewController?) {
        
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
        
            paretentViewController?.addChildViewController(childVc)
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

// mark - 遵守UIcollectionView  的 delegate
extension PageContainView : UICollectionViewDelegate {

    /*
     这两个方法是手动触发的
     */
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isForbidScrollDelegate = false
        
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // 0. 判断是否是点击事件
        if isForbidScrollDelegate {return}
        
        
        // 1. 定义获去需要的数据
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        // 2. 判断是左滑还是右滑动
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX { //左滑
            
            // 1. 计算progress
            // floor 函数是取出整数的部分
            let myFloor : CGFloat = floor(currentOffsetX / scrollViewW)
//            print("左滑" ,myFloor)
            progress = currentOffsetX / scrollViewW - myFloor
            
            // 2. 计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            
            // 3. 计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                
                targetIndex = childVcs.count - 1
            }
            
            // 4. 如果完全滑过去
            if currentOffsetX - startOffsetX == scrollViewW {
                
                progress = 1
                targetIndex = sourceIndex
            }
            
        } else { // 右滑
        
            // 1. 计算progress
            let myFloor : CGFloat = floor(currentOffsetX / scrollViewW)
//            print("右滑" ,  myFloor)
            progress = 1 - (currentOffsetX / scrollViewW - myFloor)
            
            // 2. 计算sourceIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            
            // 3. 计算targetIndex
            sourceIndex  = targetIndex + 1
            if targetIndex >= childVcs.count {
                
                sourceIndex = childVcs.count - 1
            }
        
        }
        
        // 3. 将 progress sourceIndex targetIndex 传递给 titleView
        print("progress = \(progress) ,  sourceIndex = \(sourceIndex) , targetIndex = \(targetIndex) ")
        
        delegate?.pageContainView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
    }

}


// mark - 对外暴露的方法
extension PageContainView {

    func setCurrentIndex(currentIndex : Int)  {
        
        // 1. 记录需要执行的代理方法
        isForbidScrollDelegate = true
        
        // 2. 滚到正确的位置
        let offset = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x : offset , y : 0), animated: false)
        
        
    }

}
