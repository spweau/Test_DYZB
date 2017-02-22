//
//  RecommendViewController.swift
//  Test_DYZB
//
//  Created by Spweau on 2017/2/23.
//  Copyright © 2017年 sp. All rights reserved.
//

import UIKit

// mark- 定义常量
private let kItemMargin : CGFloat = 10
private let kItemW = (kScreenW - 3 * kItemMargin) / 2
private let kItemH = kItemW * 3 / 4
private let kHeaderViewH : CGFloat = 50

private let kNormalCellID = "kNormalCellID"
private let kHeaderViewID = "kHeaderViewID"


class RecommendViewController: UIViewController {

    // lazy load
    fileprivate lazy var collectionView : UICollectionView = { [unowned self] in
    
        // 1. 创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        // 设置组头
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        // 设置组的内边距
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        // 2. 创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds ,collectionViewLayout:layout )
        collectionView.backgroundColor = UIColor.white
        
        collectionView.dataSource = self
        collectionView.delegate = self
        // 添加约束
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        // 注册cell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCellID)
        
        // 注册组头View
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        return collectionView
    }()
    
    // cycle life
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
        
        // 设置UI界面
        setupUI()
        
        
        
    }
 

}

// mark - 设置UI界面内容
extension RecommendViewController {

    fileprivate func setupUI() {
    
        //1.添加collectionView
        view.addSubview(collectionView)
    
        
        
    }

}


//Mark - UICollectionView 的 dataSource 代理方法
extension RecommendViewController : UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        // 默认12
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // 第一组 8个 ， 其它 4个
        if section == 0 {
        
            return 8
        }
        
        return 4
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
        
        cell.backgroundColor = UIColor.red
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        // 1. 取出section的headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath)
        
        headerView.backgroundColor = UIColor.green
        
        return headerView
    }
    
}


// Mark - UICollectionView 的 delegate 代理方法
extension RecommendViewController : UICollectionViewDelegate {
    
    
    
}
