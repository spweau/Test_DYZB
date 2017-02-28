//
//  NetWorkTools.swift
//  AlamofireDemo
//
//  Created by Spweau on 2017/2/23.
//  Copyright © 2017年 Spweau. All rights reserved.
//

import UIKit
import Alamofire


enum MethodType {

    case GET
    case POST
    

}

class NetWorkTools {

    

    
    class func requestData(type : MethodType , URLString : String , parameters : [String : Any]? = nil , finishCallback : @escaping (_ result : Any) -> ()) {
        
        
        
        // Any 和 AnyObject 的区别
        
        print(URLString,parameters ?? "parameters == nil")
        
        // 1. 获取类型
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        
        // 2. 发送网络请求
        Alamofire.request(URLString ,method
            :method ,parameters: parameters ).responseJSON { (response) in
                
                // 3. 获取结果
                guard let result = response.result.value else {
                    // http://www.douyutv.com/api/v1/slide/6?version=2.300
                    print(parameters ?? "parameters==nil")
                    print(URLString)
                    print(response.result.error ?? "error not info")
                    return
                }
                
                // 4. 将结果回调出去
                print(result)
                
                finishCallback(result)
                
                
        }
        
        
    }
    
}
