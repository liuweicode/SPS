//
//  UIColor_Extension.swift
//  JuMiHang
//
//  Created by 刘伟 on 4/8/15.
//  Copyright (c) 2015 Louding. All rights reserved.
//

import UIKit

extension UIColor {

    class func colorFromRGB(r:CGFloat, g:CGFloat, b:CGFloat) -> UIColor{
        return UIColor(red:((r) / 255.0)  , green: ((g) / 255.0), blue: ((b) / 255.0), alpha: 1.0);
    }
    
    class func colorFromRGBA(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor{
        return UIColor(red:((r) / 255.0)  , green: ((g) / 255.0), blue: ((b) / 255.0), alpha: (a));
    }
    
    class func colorFromHexRGB(rgbValue:Int) -> UIColor{
        return UIColor(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16))/255.0, green: ((CGFloat)((rgbValue & 0xFF00) >> 8))/255.0, blue: ((CGFloat)(rgbValue & 0xFF))/255.0, alpha: 1.0);
    }
    class func colorFromHexRGBA(rgbValue:Int, a:CGFloat) -> UIColor{
        return UIColor(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16))/255.0, green: ((CGFloat)((rgbValue & 0xFF00) >> 8))/255.0, blue: ((CGFloat)(rgbValue & 0xFF))/255.0, alpha: (a));
    }
    
    class func randomColor()->UIColor
    {
        var hue:CGFloat = ( CGFloat(arc4random()) % 256 / 256.0 );
        var saturation:CGFloat = ( CGFloat(arc4random()) % 128 / 256.0 ) + 0.5;
        var brightness:CGFloat = ( CGFloat(arc4random()) % 128 / 256.0 ) + 0.5;
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }
    
}
