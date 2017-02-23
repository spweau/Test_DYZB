//
//  NSDate-Extension.swift
//  Test_DYZB
//
//  Created by Spweau on 2017/2/23.
//  Copyright © 2017年 sp. All rights reserved.
//

import UIKit

extension NSDate {

    class func getCurrentTime() -> String {
        
        let nowDate = NSDate()
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
    }

}
