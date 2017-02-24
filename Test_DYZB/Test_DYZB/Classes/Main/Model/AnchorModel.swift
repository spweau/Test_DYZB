//
//  AnchorModel.swift
//  Test_DYZB
//
//  Created by Spweau on 2017/2/24.
//  Copyright © 2017年 sp. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {

    /*
     specific_catalog
     ranktype
     subject
     room_src
     cate_id
     specific_status
     game_name
     avatar_small
     avatar_mid
     vod_quality
     child_id
     show_time
     show_status
     jumpUrl
     */
    
    /// 房间ID
    var room_id : Int = 0
    
    /// 房间图片对应的URLString
    var vertical_src : String = ""
    
    /// 判断是手机直播还是电脑直播
    // 0 : 电脑直播 1 : 手机直播
    var isVertical : Int = 0
    
    /// 房间名称
    var room_name : String = ""
    
    /// 主播昵称
    var nickname : String = ""
    
    /// 观看人数
    var online : Int = 0
    
    /// 所在城市  在颜值 里面的字段
    var anchor_city : String = ""

    init(dict : [String : NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}

    
}
