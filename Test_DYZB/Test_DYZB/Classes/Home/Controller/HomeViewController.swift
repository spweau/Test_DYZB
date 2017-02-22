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
        
        let btn = UIButton()
        btn.setImage(UIImage(named:"logo"), for: .normal)
        btn.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
    
        
        // 设置右侧的item
        let historyBtn = UIButton()
        historyBtn.setImage(UIImage(named:""), for: .normal)
        historyBtn.setImage(UIImage(named:""), for: .highlighted)
        historyBtn.sizeToFit()
        let historyItem =  UIBarButtonItem(customView: historyBtn)
        
        
        let searchBtn = UIButton()
        searchBtn.setImage(UIImage(named:""), for: .normal)
        searchBtn.setImage(UIImage(named:""), for: .highlighted)
        searchBtn.sizeToFit()
        let searchItem = UIBarButtonItem(customView: searchBtn)
        
        
        let qrcodeBtn = UIButton()
        qrcodeBtn.setImage(UIImage(named:""), for: .normal)
        qrcodeBtn.setImage(UIImage(named:""), for: .highlighted)
        qrcodeBtn.sizeToFit()
        let qrcodeItem = UIBarButtonItem(customView: qrcodeBtn)
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem];
        
    
    }


}
