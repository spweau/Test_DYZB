//
//  CollectionPrettyCell.swift
//  Test_DYZB
//
//  Created by Spweau on 2017/2/23.
//  Copyright © 2017年 sp. All rights reserved.
//

import UIKit
import Kingfisher


class CollectionPrettyCell: CollectionBaseCell {

    // MARK:- 控件属性
    @IBOutlet weak var cityBtn: UIButton!
    
    // 定义模型属性
    override var anchor : AnchorModel? {
        didSet { 
            
            // 1.将属性传递给父类
            super.anchor = anchor
            // 2.  封面
            guard let iconURL = URL(string: (anchor?.vertical_src)!) else { return }
            iconImageView.kf.setImage(with: iconURL)
        }
    }

}
