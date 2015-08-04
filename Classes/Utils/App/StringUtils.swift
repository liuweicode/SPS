//
//  StringUtils.swift
//  isflyer
//
//  Created by 楼顶 on 15/5/20.
//  Copyright (c) 2015年 楼顶. All rights reserved.
//

import UIKit

class StringUtils: NSObject {
   
    /// 判断是否是nil或者空字符串
    class func isNilOrEmpty(text:String?) -> Bool
    {
        if let str = text
        {
            return str.isEmpty
        }
        return true
    }
    
    /// 判断是否不是nil或者空字符串
    class func isNotNilOrEmpty(text:String?) -> Bool
    {
        return !isNilOrEmpty(text)
    }
}
