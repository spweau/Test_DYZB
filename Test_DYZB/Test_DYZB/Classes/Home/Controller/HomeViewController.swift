//
//  HomeViewController.swift
//  Test_DYZB
//
//  Created by 欧亚美 on 2017/1/6.
//  Copyright © 2017年 sp. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {

    // 懒加载 pageTitleView
    fileprivate lazy var pageTitleview : PageTitleview = { [weak self] in
    
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles : [String] = ["推荐" , "游戏" , "娱乐" , "趣玩"]
        let titleView = PageTitleview(frame: titleFrame, titles: titles)
        titleView.backgroundColor = UIColor.white
        
        // 设置代理
        titleView.delegate = self
        
        return titleView
    }()
    
    fileprivate lazy var pageContentView : PageContainView = { [weak self] in
    
        // 1. 确定内容的frame
        let contentH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH
        let contentFrame = CGRect(x: 0, y:  kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
        // 2. 确定所有的子控制器
        var childVcs = [UIViewController]()
        for _ in 0..<4 {
        
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        
        let contentView = PageContainView(frame: contentFrame, childVcs: childVcs, paretentViewController: self)
        
        contentView.delegate = self
        
        return contentView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置 UI 界面
        setupUI()
        
    }
    
    /*
     1. 首页界面的titleView 封装
        1> 自定义view，并且自定义构造函数
        2> 添加子控件：1>UIScrollView  2>设置UIcollectionView 3>设置顶部的线段
     2. pageController 的封装
        1> 自定义View并且自定义构造函数
        2> 添加子控件 1>UICollectionView 2>给UICollectionView设置内容
     3. 处理titleView 与 pageController的逻辑
        1> PageTitleView发生点击事件
           1.1> 将PageTitleView中逻辑进行处理
           1.2> 告知PageTitleView滚动到正确的控制器
        2>PageContentView的滚动
    */
    
    

}

 
// MARK:- 设置UI界面
extension HomeViewController {

    fileprivate func setupUI() {
    
        // 1. 设置导航栏
        setupNavigationBar()
    
        // 2. 添加pageTitleview
        view.addSubview(pageTitleview)

        // 3. 添加 pageContentVikew
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
        
    }
    
    
    // 设置 导航栏
    private func setupNavigationBar() {
    
        // 设置左侧按键
        
//        let btn = UIButton()
//        btn.setImage(UIImage(named:"logo"), for: .normal)
//        btn.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
    
        /*
         1. 直接 添加
         2. 扩充类方法
         3. 扩充构造方法
         */
        
        
        let size = CGSize(width: 40, height: 40);
        // 设置右侧的item
//        let historyBtn = UIButton()
//        historyBtn.setImage(UIImage(named:""), for: .normal)
//        historyBtn.setImage(UIImage(named:""), for: .highlighted)
//        historyBtn.backgroundColor = UIColor.red
////        historyBtn.sizeToFit()
//        // CGPointZero 报错 ，不能使用
        
//        historyBtn.frame = CGRect(origin: CGPoint(x:0,y:0), size: size)
//        print("historyBtn.frame = \(historyBtn.frame)")
//        let historyItem =  UIBarButtonItem(customView: historyBtn)
        
//        let historyItem = UIBarButtonItem.createItem(imageName: "", hightImageName: "", size: size)
//        let searchItem = UIBarButtonItem.createItem(imageName: "", hightImageName: "", size: size)
//        let qrcodeItem = UIBarButtonItem.createItem(imageName: "", hightImageName: "", size: size)
        
        
        
        let historyItem = UIBarButtonItem(imageName: "", hightImageName: "", size: size)
        let searchItem = UIBarButtonItem(imageName: "", hightImageName: "", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "", hightImageName: "", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem];
        
    
    }


}


// mark - 遵守PageTitleviewDelegate协议
extension HomeViewController : PageTitleviewDelegate {

    func pageTitleView(titleView: PageTitleview, selectIndex index: Int) {
        
        print(index)
        
        pageContentView.setCurrentIndex(currentIndex: index)
        
        
        
    }


}


// mark- 遵守PageContainViewDelegate协议
extension HomeViewController : PageContainViewDelegate {

    func pageContainView(contentView: PageContainView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        
        pageTitleview.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }

}

