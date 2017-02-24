//
//  CollectionNormalCell.swift
//  Test_DYZB
//
//  Created by Spweau on 2017/2/23.
//  Copyright © 2017年 sp. All rights reserved.
//

import UIKit

class CollectionNormalCell: CollectionBaseCell {

    // MARK:- 控件属性 
    @IBOutlet weak var roomNameLabel: UILabel!
    
    // 定义模型属性
    override var anchor : AnchorModel? {
        didSet {
            
            // 1.将属性传递给父类
            super.anchor = anchor
            // 2. 设置房间名称
            roomNameLabel.text = anchor?.room_name
            
        }
    }

}
