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
    fileprivate lazy var pageTitleview : PageTitleview = {
    
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles : [String] = ["推荐" , "游戏" , "娱乐" , "趣玩"]
        let titleView = PageTitleview(frame: titleFrame, titles: titles)
        titleView.backgroundColor = UIColor.white
        return titleView
    }()
    
    fileprivate lazy var pageContentVikew : PageContainView = {
    
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
        return contentView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置 UI 界面
        setupUI()
        
    }
    
    
    // 1. 首页界面的titleView 封装
    // 2. pageController 的封装
    // 3. 处理titleView 与 pageController的逻辑
    
    
    
    

}

 
// MARK:- 设置UI界面
extension HomeViewController {

    fileprivate func setupUI() {
    
        // 1. 设置导航栏
        setupNavigationBar()
    
        // 2. 添加pageTitleview
        view.addSubview(pageTitleview)

        // 3. 添加 pageContentVikew
        view.addSubview(pageContentVikew)
        pageContentVikew.backgroundColor = UIColor.purple
        
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

