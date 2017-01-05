//
//  MainViewController.swift
//  Test_DYZB
//
//  Created by 欧亚美 on 2017/1/5.
//  Copyright © 2017年 sp. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("addChildViewController")
        
        // let vc = UIViewController()
        // vc.view.backgroundColor = UIColor.white
        // addChildViewController()
        
        
        addChildVc(storyboardName: "Home")
        addChildVc(storyboardName: "Live")
        addChildVc(storyboardName: "Video")
        addChildVc(storyboardName: "Follow")
        addChildVc(storyboardName: "Profile")
        
        
        
    }
    
    
    private func addChildVc(storyboardName : String)
    {
    
        // 通过stroryboard 获取 控制器
        let childVc = UIStoryboard(name: storyboardName, bundle: nil).instantiateInitialViewController()!
        
        // 添加为子控制器
        addChildViewController(childVc)
    
    }
    
    

    private func testAddVc()
    {
    
        // 通过stroryboard 获取 控制器
        let homeVc = UIStoryboard(name: "Home", bundle: nil).instantiateInitialViewController()!
        
        // 添加为子控制器
        addChildViewController(homeVc)
        
        /*
         1. bundle: nil 代表 是从 mian.storyboard 添加
         2. instantiateInitialViewController 就相当于 是 箭头指向的控制器
         其返回类型是 可选类型
         3. addChildViewController  添加的控制器是 确定类型
         所以 instantiateInitialViewController() 后面要添加 ！ 使其变为 确定类型
         
         */
    
    
    }
  

}
