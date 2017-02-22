//
//  HomeViewController.swift
//  Test_DYZB
//
//  Created by 欧亚美 on 2017/1/6.
//  Copyright © 2017年 sp. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置 UI 界面
        setupUI()
        
    }
    

    

}

// swift 语法
// MARK:- 设置UI界面
extension HomeViewController {

    fileprivate func setupUI() {
    
        // 1. 设置导航栏
        setupNavigationBar()
    
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

/*
 1. 扩充类方法
 
 2. 扩充构造函数 （推荐）
 
 
 
 */
