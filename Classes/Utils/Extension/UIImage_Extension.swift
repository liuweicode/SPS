//
//  UIImage_Extension.swift
//  JuMiHang
//
//  Created by 刘伟 on 4/28/15.
//  Copyright (c) 2015 Louding. All rights reserved.
//

import UIKit

extension UIImage {

    class func imageWithColor(color:UIColor,size:CGSize) -> UIImage
    {
        var rect = CGRectMake(0, 0, size.width, size.height);
        
        // 画图开始
        UIGraphicsBeginImageContext(size);
        // 获取图形设备上下文
        var context = UIGraphicsGetCurrentContext();
        // 设置填充颜色
        CGContextSetFillColorWithColor(context, color.CGColor);
        // 用所设置的填充颜色填充
        CGContextFillRect(context, rect);
        // 得到图片
        var image = UIGraphicsGetImageFromCurrentImageContext();
        // 画图结束，解释资源
        UIGraphicsEndImageContext();
        return image;
    }
    
    // Resizes an input image (self) to a specified size
    func resizeToSize(size: CGSize!) -> UIImage? {
        // Begins an image context with the specified size
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0);
        // Draws the input image (self) in the specified size
        self.drawInRect(CGRectMake(0, 0, size.width, size.height))
        // Gets an UIImage from the image context
        let result = UIGraphicsGetImageFromCurrentImageContext()
        // Ends the image context
        UIGraphicsEndImageContext();
        // Returns the final image, or NULL on error
        return result;
    }
    
    // Crops an input image (self) to a specified rect
    func cropToRect(rect: CGRect!) -> UIImage? {
        // Correct rect size based on the device screen scale
        let scaledRect = CGRectMake(rect.origin.x * self.scale, rect.origin.y * self.scale, rect.size.width * self.scale, rect.size.height * self.scale);
        // New CGImage reference based on the input image (self) and the specified rect
        let imageRef = CGImageCreateWithImageInRect(self.CGImage, scaledRect);
        // Gets an UIImage from the CGImage
        let result = UIImage(CGImage: imageRef, scale: self.scale, orientation: self.imageOrientation)
        // Returns the final image, or NULL on error
        return result;
    }
}
