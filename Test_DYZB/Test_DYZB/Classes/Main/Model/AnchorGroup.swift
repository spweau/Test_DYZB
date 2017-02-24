//
//  AnchorGroup.swift
//  Test_DYZB
//
//  Created by Spweau on 2017/2/24.
//  Copyright © 2017年 sp. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {

    /// 该组中对应的房间信息
    var room_list : [[String : NSObject]]? {
    
        didSet {
            
            guard let room_list = room_list else { return }
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
        }
     }
    
    /// 显示的标题
    var tag_name : String = ""
    
    
    /// 组显示的图标
    var icon_url : String = "home_header_normal"
    
  
    /// 定义主播的模型对象数组
    lazy var anchors : [AnchorModel] = [AnchorModel]()
    
    // MARK:- 重写父类的构造函数  用来保存颜值主播的model
    override init() {
        
    }
    
    init(dict : [String : NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}

    // 重写此方法 --> 是为了 定义主播的模型对象数组
//    override func setValue(_ value: Any?, forKey key: String) {
//    
//        if key == "room_list" {
//        
//            if let dataArr = value as? [String : NSObject] {
//            
//                for dict  in dataArr {
//                    // 注意 ： 这里有警告 ？  未知原因
//                    anchors.append(AnchorModel(dict: (dict as! [String : NSObject])))
//                }
//            }
//        
//        }
//    
//    }
    
}
