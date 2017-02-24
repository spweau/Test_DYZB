//
//  RecommendViewModel.swift
//  Test_DYZB
//
//  Created by Spweau on 2017/2/23.
//  Copyright © 2017年 sp. All rights reserved.
//

import UIKit

class RecommendViewModel {

    // MARK:- 懒加载属性
    // 0  1    2 - 12
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
    
    
    // 创建 热门
    fileprivate lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    
    // 创建 颜值
    fileprivate lazy var prettyGroup : AnchorGroup = AnchorGroup()
    
}

// mark - 发送网络请求
extension RecommendViewModel {

    func requestData(_ finishCallback : @escaping () -> ())  {
     
        // 0. 定义参数
        let parameters : [String : Any] = ["limit" : 4 , "offset" : 0 ,"time" : NSDate.getCurrentTime()]
        
        // 创建线程组
        let dGroup = DispatchGroup()
        
        // 1. 请求第一部分推荐数据
        print("http://capi.douyucdn.cn/api/v1/getbigDataRoom?time=\(NSDate.getCurrentTime())")
        
        dGroup.enter()
        
        NetWorkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : NSDate.getCurrentTime()]) { (result) in
            
            //print(result)
            
            // 1.将result转成字典类型
            guard let resultDic = result as? [String : NSObject] else { return }
            
            // 2. 根据data该key获取数组，（顺便将arr转化）
            guard let dataArr = resultDic["data"] as? [[String : NSObject]] else { return }
            
            // 3  遍历数组，获取字典，并将字典转成模型对象
            // 3.1 创建组
//            let group = AnchorGroup()
            // 3.2 给组设置属性
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_url = "home_header_hot"
            // 3.3 获取主播数据
            for dict in dataArr {
                
                let anchor = AnchorModel(dict:dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            
            
            // 4.离开组
            dGroup.leave()
            print("请求到0组数据")
        }

        
        
        
        
        
        // 2. 请求第二部分颜值数据 ttp://capi.douyucdn.cn/api/v1/getVerticalRoom
        
        print("http://capi.douyucdn.cn/api/v1/getVerticalRoom?limit=4&offset=0&time=\(NSDate.getCurrentTime())")
        
        dGroup.enter()
        
        NetWorkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { (result) in
            
            //print(result)
            
            // 1.将result转成字典类型
            guard let resultDic = result as? [String : NSObject] else { return }
            
            // 2. 根据data该key获取数组，（顺便将arr转化）
            guard let dataArr = resultDic["data"] as? [[String : NSObject]] else { return }
            
            // 3  遍历数组，获取字典，并将字典转成模型对象
            // 3.1 创建组
//            let group = AnchorGroup()
            // 3.2 给组设置属性
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_url = "home_header_phone"
            // 3.3 获取主播数据
            for dict in dataArr {
                
                let anchor = AnchorModel(dict:dict)
                self.prettyGroup.anchors.append(anchor)
            }
            
            // 4.离开组
            dGroup.leave()
            print("请求到1组数据")
        }
        
        
        
        // 2 - 12 部分的数据 请求第三部分游戏书库 http://capi.douyucdn.cn/api/v1/getHotCate 有数据
        // 3.1 获取当前时间
        
        // 拼接的字符串
        //http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=
//        let nowTimeStr : String = NSDate.getCurrentTime()
//        
//        print("http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=\(nowTimeStr)")
        
        dGroup.enter()
        
        NetWorkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { (result) in
            
            //print(result)
            
            // 1.将result转成字典类型
            guard let resultDic = result as? [String : NSObject] else { return }
            
            // 2. 根据data该key获取数组，（顺便将arr转化）
            guard let dataArr = resultDic["data"] as? [[String : NSObject]] else { return }
            
            // 3  遍历数组，获取字典，并将字典转成模型对象
            for dict in dataArr {
            
                let anchor = AnchorGroup(dict: dict)
                self.anchorGroups.append(anchor)
            
            }
            
            
            // 4.离开组
            dGroup.leave()
            print("请求到2 - 12组数据")
            
//            for group in self.anchorGroups {
//            
//                print(group.tag_name)
//                /*
//                 英雄联盟
//                 颜值
//                 户外
//                 守望先锋
//                 数码科技
//                 皇室战争
//                 星秀
//                 鱼教
//                 炉石传说
//                 DOTA2
//                  */
//                print("-------group.tag_name---------")
//                
//                for group in self.anchorGroups {
//                
//                    for anchor in group.anchors {
//                    
//                        print(anchor.nickname)
//                    }
//                print("--------anchor.nickname--------")
//                }
//            
//                
//            }
            
            
        }
        
        
        // 6.所有的数据都请求到,之后进行排序
        dGroup.notify(queue: DispatchQueue.main) {
            
            print("请求到所有组数据")
            
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            finishCallback()
        }
        
    }

}

/*
 英雄联盟
 -------group.tag_name---------
 赛事专用直播间
 主播阿俊a
 woq1148128208
 暴走DL
 --------anchor.nickname--------
 --------anchor.nickname--------
 叶子户外
 老乡开下门
 魅力生活i
 清新脱俗的柚子皮
 --------anchor.nickname--------
 暴雪粉丶裁决
 小杰看着小杰西索
 铃声QvQ
 Coffee咖啡因
 --------anchor.nickname--------
 OC频道包大人
 重庆恒刚金牌装机店
 蛋定的深白西瓜
 北京玩家国度攒机
 --------anchor.nickname--------
 航空鸣圣
 伐木累丶路飞
 度援
 鲤老四
 --------anchor.nickname--------
 肉肉Selena丶
 月子小宝贝
 隋之道
 mtk002
 --------anchor.nickname--------
 张昕宇梁红
 南博直播
 画图小余
 長腿小公主桑妮
 --------anchor.nickname--------
 莫忘逍遥oO
 雪月救赎哥
 灬小灬虎灬
 顾亦川的旧梦歌
 --------anchor.nickname--------
 余贰人
 登峰王
 战术大师rubick
 smileasme
 --------anchor.nickname--------
 颜值
 -------group.tag_name---------
 赛事专用直播间
 主播阿俊a
 woq1148128208
 暴走DL
 --------anchor.nickname--------
 --------anchor.nickname--------
 叶子户外
 老乡开下门
 魅力生活i
 清新脱俗的柚子皮
 --------anchor.nickname--------
 暴雪粉丶裁决
 小杰看着小杰西索
 铃声QvQ
 Coffee咖啡因
 --------anchor.nickname--------
 OC频道包大人
 重庆恒刚金牌装机店
 蛋定的深白西瓜
 北京玩家国度攒机
 --------anchor.nickname--------
 航空鸣圣
 伐木累丶路飞
 度援
 鲤老四
 --------anchor.nickname--------
 肉肉Selena丶
 月子小宝贝
 隋之道
 mtk002
 --------anchor.nickname--------
 张昕宇梁红
 南博直播
 画图小余
 長腿小公主桑妮
 --------anchor.nickname--------
 莫忘逍遥oO
 雪月救赎哥
 灬小灬虎灬
 顾亦川的旧梦歌
 --------anchor.nickname--------
 余贰人
 登峰王
 战术大师rubick
 smileasme
 --------anchor.nickname--------
 户外
 -------group.tag_name---------
 赛事专用直播间
 主播阿俊a
 woq1148128208
 暴走DL
 --------anchor.nickname--------
 --------anchor.nickname--------
 叶子户外
 老乡开下门
 魅力生活i
 清新脱俗的柚子皮
 --------anchor.nickname--------
 暴雪粉丶裁决
 小杰看着小杰西索
 铃声QvQ
 Coffee咖啡因
 --------anchor.nickname--------
 OC频道包大人
 重庆恒刚金牌装机店
 蛋定的深白西瓜
 北京玩家国度攒机
 --------anchor.nickname--------
 航空鸣圣
 伐木累丶路飞
 度援
 鲤老四
 --------anchor.nickname--------
 肉肉Selena丶
 月子小宝贝
 隋之道
 mtk002
 --------anchor.nickname--------
 张昕宇梁红
 南博直播
 画图小余
 長腿小公主桑妮
 --------anchor.nickname--------
 莫忘逍遥oO
 雪月救赎哥
 灬小灬虎灬
 顾亦川的旧梦歌
 --------anchor.nickname--------
 余贰人
 登峰王
 战术大师rubick
 smileasme
 --------anchor.nickname--------
 守望先锋
 -------group.tag_name---------
 赛事专用直播间
 主播阿俊a
 woq1148128208
 暴走DL
 --------anchor.nickname--------
 --------anchor.nickname--------
 叶子户外
 老乡开下门
 魅力生活i
 清新脱俗的柚子皮
 --------anchor.nickname--------
 暴雪粉丶裁决
 小杰看着小杰西索
 铃声QvQ
 Coffee咖啡因
 --------anchor.nickname--------
 OC频道包大人
 重庆恒刚金牌装机店
 蛋定的深白西瓜
 北京玩家国度攒机
 --------anchor.nickname--------
 航空鸣圣
 伐木累丶路飞
 度援
 鲤老四
 --------anchor.nickname--------
 肉肉Selena丶
 月子小宝贝
 隋之道
 mtk002
 --------anchor.nickname--------
 张昕宇梁红
 南博直播
 画图小余
 長腿小公主桑妮
 --------anchor.nickname--------
 莫忘逍遥oO
 雪月救赎哥
 灬小灬虎灬
 顾亦川的旧梦歌
 --------anchor.nickname--------
 余贰人
 登峰王
 战术大师rubick
 smileasme
 --------anchor.nickname--------
 数码科技
 -------group.tag_name---------
 赛事专用直播间
 主播阿俊a
 woq1148128208
 暴走DL
 --------anchor.nickname--------
 --------anchor.nickname--------
 叶子户外
 老乡开下门
 魅力生活i
 清新脱俗的柚子皮
 --------anchor.nickname--------
 暴雪粉丶裁决
 小杰看着小杰西索
 铃声QvQ
 Coffee咖啡因
 --------anchor.nickname--------
 OC频道包大人
 重庆恒刚金牌装机店
 蛋定的深白西瓜
 北京玩家国度攒机
 --------anchor.nickname--------
 航空鸣圣
 伐木累丶路飞
 度援
 鲤老四
 --------anchor.nickname--------
 肉肉Selena丶
 月子小宝贝
 隋之道
 mtk002
 --------anchor.nickname--------
 张昕宇梁红
 南博直播
 画图小余
 長腿小公主桑妮
 --------anchor.nickname--------
 莫忘逍遥oO
 雪月救赎哥
 灬小灬虎灬
 顾亦川的旧梦歌
 --------anchor.nickname--------
 余贰人
 登峰王
 战术大师rubick
 smileasme
 --------anchor.nickname--------
 皇室战争
 -------group.tag_name---------
 赛事专用直播间
 主播阿俊a
 woq1148128208
 暴走DL
 --------anchor.nickname--------
 --------anchor.nickname--------
 叶子户外
 老乡开下门
 魅力生活i
 清新脱俗的柚子皮
 --------anchor.nickname--------
 暴雪粉丶裁决
 小杰看着小杰西索
 铃声QvQ
 Coffee咖啡因
 --------anchor.nickname--------
 OC频道包大人
 重庆恒刚金牌装机店
 蛋定的深白西瓜
 北京玩家国度攒机
 --------anchor.nickname--------
 航空鸣圣
 伐木累丶路飞
 度援
 鲤老四
 --------anchor.nickname--------
 肉肉Selena丶
 月子小宝贝
 隋之道
 mtk002
 --------anchor.nickname--------
 张昕宇梁红
 南博直播
 画图小余
 長腿小公主桑妮
 --------anchor.nickname--------
 莫忘逍遥oO
 雪月救赎哥
 灬小灬虎灬
 顾亦川的旧梦歌
 --------anchor.nickname--------
 余贰人
 登峰王
 战术大师rubick
 smileasme
 --------anchor.nickname--------
 星秀
 -------group.tag_name---------
 赛事专用直播间
 主播阿俊a
 woq1148128208
 暴走DL
 --------anchor.nickname--------
 --------anchor.nickname--------
 叶子户外
 老乡开下门
 魅力生活i
 清新脱俗的柚子皮
 --------anchor.nickname--------
 暴雪粉丶裁决
 小杰看着小杰西索
 铃声QvQ
 Coffee咖啡因
 --------anchor.nickname--------
 OC频道包大人
 重庆恒刚金牌装机店
 蛋定的深白西瓜
 北京玩家国度攒机
 --------anchor.nickname--------
 航空鸣圣
 伐木累丶路飞
 度援
 鲤老四
 --------anchor.nickname--------
 肉肉Selena丶
 月子小宝贝
 隋之道
 mtk002
 --------anchor.nickname--------
 张昕宇梁红
 南博直播
 画图小余
 長腿小公主桑妮
 --------anchor.nickname--------
 莫忘逍遥oO
 雪月救赎哥
 灬小灬虎灬
 顾亦川的旧梦歌
 --------anchor.nickname--------
 余贰人
 登峰王
 战术大师rubick
 smileasme
 --------anchor.nickname--------
 鱼教
 -------group.tag_name---------
 赛事专用直播间
 主播阿俊a
 woq1148128208
 暴走DL
 --------anchor.nickname--------
 --------anchor.nickname--------
 叶子户外
 老乡开下门
 魅力生活i
 清新脱俗的柚子皮
 --------anchor.nickname--------
 暴雪粉丶裁决
 小杰看着小杰西索
 铃声QvQ
 Coffee咖啡因
 --------anchor.nickname--------
 OC频道包大人
 重庆恒刚金牌装机店
 蛋定的深白西瓜
 北京玩家国度攒机
 --------anchor.nickname--------
 航空鸣圣
 伐木累丶路飞
 度援
 鲤老四
 --------anchor.nickname--------
 肉肉Selena丶
 月子小宝贝
 隋之道
 mtk002
 --------anchor.nickname--------
 张昕宇梁红
 南博直播
 画图小余
 長腿小公主桑妮
 --------anchor.nickname--------
 莫忘逍遥oO
 雪月救赎哥
 灬小灬虎灬
 顾亦川的旧梦歌
 --------anchor.nickname--------
 余贰人
 登峰王
 战术大师rubick
 smileasme
 --------anchor.nickname--------
 炉石传说
 -------group.tag_name---------
 赛事专用直播间
 主播阿俊a
 woq1148128208
 暴走DL
 --------anchor.nickname--------
 --------anchor.nickname--------
 叶子户外
 老乡开下门
 魅力生活i
 清新脱俗的柚子皮
 --------anchor.nickname--------
 暴雪粉丶裁决
 小杰看着小杰西索
 铃声QvQ
 Coffee咖啡因
 --------anchor.nickname--------
 OC频道包大人
 重庆恒刚金牌装机店
 蛋定的深白西瓜
 北京玩家国度攒机
 --------anchor.nickname--------
 航空鸣圣
 伐木累丶路飞
 度援
 鲤老四
 --------anchor.nickname--------
 肉肉Selena丶
 月子小宝贝
 隋之道
 mtk002
 --------anchor.nickname--------
 张昕宇梁红
 南博直播
 画图小余
 長腿小公主桑妮
 --------anchor.nickname--------
 莫忘逍遥oO
 雪月救赎哥
 灬小灬虎灬
 顾亦川的旧梦歌
 --------anchor.nickname--------
 余贰人
 登峰王
 战术大师rubick
 smileasme
 --------anchor.nickname--------
 DOTA2
 -------group.tag_name---------
 赛事专用直播间
 主播阿俊a
 woq1148128208
 暴走DL
 --------anchor.nickname--------
 --------anchor.nickname--------
 叶子户外
 老乡开下门
 魅力生活i
 清新脱俗的柚子皮
 --------anchor.nickname--------
 暴雪粉丶裁决
 小杰看着小杰西索
 铃声QvQ
 Coffee咖啡因
 --------anchor.nickname--------
 OC频道包大人
 重庆恒刚金牌装机店
 蛋定的深白西瓜
 北京玩家国度攒机
 --------anchor.nickname--------
 航空鸣圣
 伐木累丶路飞
 度援
 鲤老四
 --------anchor.nickname--------
 肉肉Selena丶
 月子小宝贝
 隋之道
 mtk002
 --------anchor.nickname--------
 张昕宇梁红
 南博直播
 画图小余
 長腿小公主桑妮
 --------anchor.nickname--------
 莫忘逍遥oO
 雪月救赎哥
 灬小灬虎灬
 顾亦川的旧梦歌
 --------anchor.nickname--------
 余贰人
 登峰王
 战术大师rubick
 smileasme
 --------anchor.nickname--------

 */
