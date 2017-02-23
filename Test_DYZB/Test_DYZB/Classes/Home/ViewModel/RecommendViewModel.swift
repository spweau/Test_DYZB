//
//  RecommendViewModel.swift
//  Test_DYZB
//
//  Created by Spweau on 2017/2/23.
//  Copyright © 2017年 sp. All rights reserved.
//

import UIKit

class RecommendViewModel {

}

// mark - 发送网络请求
extension RecommendViewModel {

    func requestData()  {
     
        // 1. 请求第一部分推荐数据
        
        // 2. 请求第二部分颜值数据
        
        // 3. 请求第三部分游戏书库 http://capi.douyucdn.cn/api/v1/getHotCate 有数据
        // 3.1 获取当前时间
        
        
        NetWorkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: ["limit" : 4 , "offset" : 0 ,"time" : NSDate.getCurrentTime()]) { (result) in
            
            print(result)
        }
        
        
    }

}

