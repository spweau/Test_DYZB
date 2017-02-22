//
//  UIBarButtonItem-Extention.swift
//  Test_DYZB
//
//  Created by Spweau on 2017/2/22.
//  Copyright © 2017年 sp. All rights reserved.
//

import UIKit

extension UIBarButtonItem {

    
//    // 1. 扩充 类方法
//    class func createItem(imageName: String , hightImageName : String , size: CGSize) -> UIBarButtonItem {
//        
//        let btn = UIButton()
//        btn.setImage(UIImage(named:imageName), for: .normal)
//        btn.setImage(UIImage(named:hightImageName), for: .highlighted)
//        btn.frame = CGRect(origin: CGPoint(x:0,y:0), size: size)
//        btn.backgroundColor = UIColor.red
//        return UIBarButtonItem(customView: btn)
//    }
    
    
    // 2. 扩充 构造方法
    
    // 便利构造函数
    // 1. convenience 开头
    // 2. 在构造函数中必须明确为调用一个设计的构造函数（并且这个设计的构造函数是使用self来调用的）
      convenience init(imageName: String , hightImageName : String = "" , size:CGSize = CGSize(width: 0, height: 0)) {
        
        // 1. 创建UIButton
        let btn = UIButton()
        
        // 2. btn 的图片
        btn.setImage(UIImage(named:imageName), for: .normal)
        
        if hightImageName != "" {
        
            btn.setImage(UIImage(named:hightImageName), for: .highlighted)
        }
        
        // 3. 设置 frame
        if size == CGSize(width: 0, height: 0)  {
            
            btn.sizeToFit()
        } else {
        
            btn.frame = CGRect(origin: CGPoint(x:0,y:0), size: size)
        }
        
        btn.backgroundColor = UIColor.red
        
        // 4. 创建 UIBarButtonItem
        self.init(customView: btn)
    }
    
    
    
    
}
