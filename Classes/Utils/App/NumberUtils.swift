//
//  NumberUtils.swift
//  isflyer
//
//  Created by 楼顶 on 15/5/20.
//  Copyright (c) 2015年 楼顶. All rights reserved.
//

import UIKit

class NumberUtils: NSObject {
   
    /// 获取随机数
    class func random(#from:Int,to:Int) -> Int {
        let count = UInt32(abs(to - from) + 1)
        return  Int(arc4random_uniform(count))  + from
    }
    
    /// 获取随机数
    class func random(#min:Int,max:Int) -> Int {
       return Int(arc4random()) % (max - min + 1) + min
    }
    
}
