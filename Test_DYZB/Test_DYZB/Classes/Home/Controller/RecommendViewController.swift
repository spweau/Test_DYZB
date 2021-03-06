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
private let kNormalItemH = kItemW * 3 / 4
private let kPrettyItemH = kItemW * 4 / 3
private let kHeaderViewH : CGFloat = 50


private let kCycleViewH = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 90

private let kNormalCellID = "kNormalCellID"
private let kPrettyCellID = "kPrettyCellID"
private let kHeaderViewID = "kHeaderViewID"


class RecommendViewController: UIViewController {


    
    
    //懒加载 属性
    fileprivate lazy var recommendVM : RecommendViewModel = RecommendViewModel()
    
    
    // lazy load
    fileprivate lazy var collectionView : UICollectionView = { [unowned self] in
    
        // 1. 创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
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
        //        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCellID)
        
        collectionView.register( UINib(nibName: "CollectionNormalCell", bundle: nil) , forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register( UINib(nibName: "CollectionPrettyCell", bundle: nil) , forCellWithReuseIdentifier: kPrettyCellID)
        
        
        // 注册组头View
        
//        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        collectionView.register( UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        return collectionView
    }()
    
    fileprivate lazy var cycleView : RecommendCycleView = {
    
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    
    fileprivate lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    
    // cycle life
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
        
        // 1.  设置UI界面
        setupUI()
        
        // 2. 网络请求
        loadData()
        
        
    }
 

}

// mark - 设置UI界面内容
extension RecommendViewController {

    fileprivate func setupUI() {
    
        //1.添加collectionView
        view.addSubview(collectionView)
    
        // 2.将CycleView添加到UICollectionView中
        collectionView.addSubview(cycleView)
        
        // 3.将gameView添加collectionView中
        //collectionView.addSubview(gameView)
        
        // 4.设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
        
    }

}

// mark - 网络请求
extension RecommendViewController {

    fileprivate func loadData() {
    
//        NetWorkTools.requestData(type: .GET, URLString: "http://httpbin.org/get", parameters: [ "name": "spweau", "age" : 26]) { (result) in 
//            print(result)
//        }
        // 1.请求推荐数据
        recommendVM.requestData { 
            
            print("--------------")
            
            self.collectionView.reloadData()
        }
    
        // 2.请求轮播数据
        recommendVM.requestCycleData {
            
            print("数据请求完成")
            
            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
        
    }

}



//Mark - UICollectionView 的 dataSource 代理方法
extension RecommendViewController : UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        // 默认12
        return recommendVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // 第一组 8个 ， 其它 4个
//        if section == 0 {
//        
//            return 8
//        }
//        
//        return 4

        
        let group = recommendVM.anchorGroups[section]
        return group.anchors.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // 0.取出模型对象
        let group = recommendVM.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]
        
        // 1. 定义cell
        var cell : CollectionBaseCell
        
        
        // 2. 取cell
        if indexPath.section == 1 {
            
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
            
        } else {
            
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
            
        }
        
        cell.anchor = anchor
        return cell
        
        //        cell.backgroundColor = UIColor.white
        //        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        // 1. 取出section的headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        
        // headerView.backgroundColor = UIColor.green
        // 取出模型
        headerView.group = recommendVM.anchorGroups[indexPath.section]
        
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 1 {
            
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
    
        return CGSize(width: kItemW, height: kNormalItemH)
    }
    
}


// Mark - UICollectionView 的 delegate 代理方法
extension RecommendViewController : UICollectionViewDelegate {
    
    
    
}
