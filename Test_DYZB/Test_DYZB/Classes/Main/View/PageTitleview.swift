//
//  PageTitleview.swift
//  Test_DYZB
//
//  Created by Spweau on 2017/2/22.
//  Copyright © 2017年 sp. All rights reserved.
//

import UIKit

// 定义一个协议 ， 用来将点击的label的时间传递给 HomeViewController --> pageContainView

protocol PageTitleviewDelegate : class {
    
    func pageTitleView (titleView : PageTitleview , selectIndex index:Int )
}

// mark- 定义常量
private let kScrollLineH : CGFloat = 2
// 灰色
private let kNormalColor : (CGFloat,CGFloat,CGFloat) = (85,85,85)
// 橘色
private let kSelectColor : (CGFloat,CGFloat,CGFloat) = (255,128,0)

class PageTitleview: UIView {
 
    // mark- 定义属性
    fileprivate var currentIndex : Int = 0
    fileprivate var titles : [String]
    
    weak var delegate : PageTitleviewDelegate?
    
    
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
        scrollLine.backgroundColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
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
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center
            
            label.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            
            // 3. 设置label的frame
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            // 4. 将label 添加到scrollView中
            scrollView.addSubview(label)
            
            // 将label添加到 数组中
            titlelabels.append(label)
            
            // 5.  给label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLAbelClick(tapGes:)))
            
            label.addGestureRecognizer(tapGes)
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
        
        firstLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)

        // 2.2 设置 scrollLine 的属性
        scrollView.addSubview(scrollLine)
        
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
        
        
    }

}


// mark : 监听label 的点击
extension PageTitleview {

    // 手势点击方法 前面 必须加上 @objc
    @objc fileprivate func titleLAbelClick(tapGes : UITapGestureRecognizer){
    
        print("----------")
        
        // 1. 获取 当前的label
        guard let currentLabel = tapGes.view as? UILabel  else { return }
        
        
        // 2. 获取之前的label
        let oldLabel = titlelabels[currentIndex]
        
        // 3. 切换文字的颜色
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)

        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        // 4. 保存最新label的下标值
        currentIndex = currentLabel.tag
    
        // 5. 滚动条位置发生改变
        let scrollLineX = CGFloat( currentLabel.tag ) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) { 
            
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        // 6. 通知代理
        delegate?.pageTitleView(titleView: self, selectIndex: currentIndex)
    }



}


// mark- 对外暴露的方法
extension PageTitleview {

    func setTitleWithProgress(progress : CGFloat , sourceIndex : Int , targetIndex : Int)  {
        
        // 1. 取出 sourceIndex targetIndex 
        let sourceLabel = titlelabels[sourceIndex]
        let targetLabel = titlelabels[targetIndex]
        
        // 2. 处理滑块逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        // 3. 颜色的渐变
        // 3.1 取出变化的范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0 ,kSelectColor.1 - kNormalColor.1 ,kSelectColor.2 - kNormalColor.2)
        
        // 3.2 变化sourceLabel targetLabel
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        // 4. 记录最新的index
        currentIndex = targetIndex
        
        
        
        
    }


}


//// MARK:- 定义协议
//protocol PageTitleviewDelegate : class {
//    func pageTitleView( titleView : PageTitleview, selectedIndex index : Int)
//}
//
//// MARK:- 定义常量
//private let kScrollLineH : CGFloat = 2
//private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
//private let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)
//
//// MARK:- 定义PageTitleView类
//class PageTitleview: UIView {
//    
//    // MARK:- 定义属性
//    fileprivate var currentIndex : Int = 0
//    fileprivate var titles : [String]
//    weak var delegate : PageTitleviewDelegate?
//    
//    // MARK:- 懒加载属性
//    fileprivate lazy var titleLabels : [UILabel] = [UILabel]()
//    fileprivate lazy var scrollView : UIScrollView = {
//        let scrollView = UIScrollView()
//        scrollView.showsHorizontalScrollIndicator = false
//        scrollView.scrollsToTop = false
//        scrollView.bounces = false
//        return scrollView
//    }()
//    fileprivate lazy var scrollLine : UIView = {
//        let scrollLine = UIView()
//        scrollLine.backgroundColor = UIColor.orange
//        return scrollLine
//    }()
//    
//    // MARK:- 自定义构造函数
//    init(frame: CGRect, titles : [String]) {
//        self.titles = titles
//        
//        super.init(frame: frame)
//        
//        // 设置UI界面
//        setupUI()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//}
//
//
//// MARK:- 设置UI界面
//extension PageTitleview {
//    fileprivate func setupUI() {
//        // 1.添加UIScrollView
//        addSubview(scrollView)
//        scrollView.frame = bounds
//        
//        // 2.添加title对应的Label
//        setupTitleLabels()
//        
//        // 3.设置底线和滚动的滑块
//        setupBottomLineAndScrollLine()
//    }
//    
//    fileprivate func setupTitleLabels() {
//        
//        // 0.确定label的一些frame的值
//        let labelW : CGFloat = frame.width / CGFloat(titles.count)
//        let labelH : CGFloat = frame.height - kScrollLineH
//        let labelY : CGFloat = 0
//        
//        for (index, title) in titles.enumerated() {
//            // 1.创建UILabel
//            let label = UILabel()
//            
//            // 2.设置Label的属性
//            label.text = title
//            label.tag = index
//            label.font = UIFont.systemFont(ofSize: 16.0)
//            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
//            label.textAlignment = .center
//            
//            // 3.设置label的frame
//            let labelX : CGFloat = labelW * CGFloat(index)
//            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
//            
//            // 4.将label添加到scrollView中
//            scrollView.addSubview(label)
//            titleLabels.append(label)
//            
//            // 5.给Label添加手势
//            label.isUserInteractionEnabled = true
//            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(_:)))
//            label.addGestureRecognizer(tapGes)
//        }
//    }
//    
//    fileprivate func setupBottomLineAndScrollLine() {
//        // 1.添加底线
//        let bottomLine = UIView()
//        bottomLine.backgroundColor = UIColor.lightGray
//        let lineH : CGFloat = 0.5
//        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
//        addSubview(bottomLine)
//        
//        // 2.添加scrollLine
//        // 2.1.获取第一个Label
//        guard let firstLabel = titleLabels.first else { return }
//        firstLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
//        
//        // 2.2.设置scrollLine的属性
//        scrollView.addSubview(scrollLine)
//        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
//    }
//}
//
//
//// MARK:- 监听Label的点击
//extension PageTitleview {
//    @objc fileprivate func titleLabelClick(_ tapGes : UITapGestureRecognizer) {
//        
//        // 0.获取当前Label
//        guard let currentLabel = tapGes.view as? UILabel else { return }
//        
//        // 1.如果是重复点击同一个Title,那么直接返回
//        if currentLabel.tag == currentIndex { return }
//        
//        // 2.获取之前的Label
//        let oldLabel = titleLabels[currentIndex]
//        
//        // 3.切换文字的颜色
//        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
//        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
//        
//        // 4.保存最新Label的下标值
//        currentIndex = currentLabel.tag
//        
//        // 5.滚动条位置发生改变
//        let scrollLineX = CGFloat(currentIndex) * scrollLine.frame.width
//        UIView.animate(withDuration: 0.15, animations: {
//            self.scrollLine.frame.origin.x = scrollLineX
//        })
//        
//        // 6.通知代理
//        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
//    }
//}
//
//// MARK:- 对外暴露的方法
//extension PageTitleview {
//    func setTitleWithProgress(_ progress : CGFloat, sourceIndex : Int, targetIndex : Int) {
//        // 1.取出sourceLabel/targetLabel
//        let sourceLabel = titleLabels[sourceIndex]
//        let targetLabel = titleLabels[targetIndex]
//        
//        // 2.处理滑块的逻辑
//        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
//        let moveX = moveTotalX * progress
//        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
//        
//        // 3.颜色的渐变(复杂)
//        // 3.1.取出变化的范围
//        let colorDelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
//        
//        // 3.2.变化sourceLabel
//        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
//        
//        // 3.2.变化targetLabel
//        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
//        
//        // 4.记录最新的index
//        currentIndex = targetIndex
//    }
//}
//
