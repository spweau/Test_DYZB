//
//  RecommendGameView.swift
//  Test_DYZB
//
//  Created by Spweau on 2017/2/25.
//  Copyright © 2017年 sp. All rights reserved.
//

import UIKit

class RecommendGameView: UIView {

 
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 让控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        
        
    }
    
    
}

extension RecommendGameView {

    class func recommendGameView() -> RecommendGameView {
    
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)!.first as! RecommendGameView
    }

}
