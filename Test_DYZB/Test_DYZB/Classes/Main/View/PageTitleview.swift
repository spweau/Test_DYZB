//
//  PageTitleview.swift
//  Test_DYZB
//
//  Created by Spweau on 2017/2/22.
//  Copyright © 2017年 sp. All rights reserved.
//

import UIKit

private let kScrollLineH : CGFloat = 2

class PageTitleview: UIView {
 
    // mark- 定义属性
    fileprivate var titles : [String]
    
    // lazy load 属性
    
    fileprivate var titlelabels : [UILabel] = [UILabel]()
    
    fileprivate lazy var scrollView : UIScrollView = {
    
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    fileprivate lazy var scrollLine : UIView = {
    
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    
    // MARK 自定义构造函数
    
    init ( frame : CGRect , titles : [String] ){
    
        self.titles = titles
        
        super.init(frame: frame)
    
        // 设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


// MArk - 设置 UI 界面
extension PageTitleview {

    fileprivate func setupUI(){
    
        // 0. 不需要调整UIScollView的内边聚 
        // swift3.0 报错
        //automaticallyAdjustScrollViewInserts = false
        
        // 1. 添加 UIScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        // -----
        // 2. 添加title对应的label
        setupTitleLabels()
        
        // 3.设置底线和滚动的滑块
        setupBottomLineAndScrollLine()
        
        
    }

    private func setupTitleLabels() {
    
        // 0. 确定label的一些frame值
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        let labelY : CGFloat = 0
        
        for (index , title) in titles.enumerated() {
            
            // 1. 创建 label
            let label = UILabel()
            
            // 2. 设置label的属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            
            // 3. 设置label的frame
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            // 4. 将label 添加到scrollView中
            scrollView.addSubview(label)
            
            // 将label添加到 数组中
            titlelabels.append(label)
            
            
            
        }
        
        
        
        
    
    
    }
    
    private func setupBottomLineAndScrollLine() {
    
        // 1. 添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width:frame.width , height: lineH)
        addSubview(bottomLine)
        
        // 2. 添加scrollLine
        // 2.1  获取第一个label
        guard let firstLabel = titlelabels.first else { return }
        
        firstLabel.textColor = UIColor.orange
        // 2.2 设置 scrollLine 的属性
        scrollView.addSubview(scrollLine)
        
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
        
        
    }

}

