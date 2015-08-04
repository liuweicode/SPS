//
//  UILabel_Extension.swift
//  isflyer
//
//  Created by 楼顶 on 15/7/20.
//  Copyright (c) 2015年 楼顶. All rights reserved.
//

import UIKit

extension UILabel {
    
    var adjustFontToRealIPhoneSize: Bool {
       
        set {
            if newValue {
                var currentFont = self.font
                var sizeScale: CGFloat = 1
                
                if UIDevice.isIphone6()
                {
                    sizeScale = 1.1
                }
                else if UIDevice.isIphone6p()
                {
                    sizeScale = 1.3
                }
                self.font = currentFont.fontWithSize(currentFont.pointSize * sizeScale)
            }
        }
        
        get {
            return false
        }
    }
    
}