//
//  UIDevice_Extension.swift
//  isflyer
//
//  Created by Fiona on 15/7/2.
//  Copyright (c) 2015年 楼顶. All rights reserved.
//

import Foundation
import UIKit
//private let DeviceList = [
//    /* iPod 5 */          "iPod5,1": "iPod Touch 5",
//    /* iPhone 4 */        "iPhone3,1":  "iPhone 4", "iPhone3,2": "iPhone 4", "iPhone3,3": "iPhone 4",
//    /* iPhone 4S */       "iPhone4,1": "iPhone 4S",
//    /* iPhone 5 */        "iPhone5,1": "iPhone 5", "iPhone5,2": "iPhone 5",
//    /* iPhone 5C */       "iPhone5,3": "iPhone 5C", "iPhone5,4": "iPhone 5C",
//    /* iPhone 5S */       "iPhone6,1": "iPhone 5S", "iPhone6,2": "iPhone 5S",
//    /* iPhone 6 */        "iPhone7,2": "iPhone 6",
//    /* iPhone 6 Plus */   "iPhone7,1": "iPhone 6 Plus",
//    /* iPad 2 */          "iPad2,1": "iPad 2", "iPad2,2": "iPad 2", "iPad2,3": "iPad 2", "iPad2,4": "iPad 2",
//    /* iPad 3 */          "iPad3,1": "iPad 3", "iPad3,2": "iPad 3", "iPad3,3": "iPad 3",
//    /* iPad 4 */          "iPad3,4": "iPad 4", "iPad3,5": "iPad 4", "iPad3,6": "iPad 4",
//    /* iPad Air */        "iPad4,1": "iPad Air", "iPad4,2": "iPad Air", "iPad4,3": "iPad Air",
//    /* iPad Air 2 */      "iPad5,1": "iPad Air 2", "iPad5,3": "iPad Air 2", "iPad5,4": "iPad Air 2",
//    /* iPad Mini */       "iPad2,5": "iPad Mini", "iPad2,6": "iPad Mini", "iPad2,7": "iPad Mini",
//    /* iPad Mini 2 */     "iPad4,4": "iPad Mini", "iPad4,5": "iPad Mini", "iPad4,6": "iPad Mini",
//    /* iPad Mini 3 */     "iPad4,7": "iPad Mini", "iPad4,8": "iPad Mini", "iPad4,9": "iPad Mini",
//    /* Simulator */       "x86_64": "Simulator", "i386": "Simulator"
//]


public enum DeviceType {
    case NotAvailable
    
    case IPhone2G
    case IPhone3G
    case IPhone3GS
    case IPhone4
    case IPhone4S
    case IPhone5
    case IPhone5C
    case IPhone5S
    case IPhone6Plus
    case IPhone6
    
    case IPodTouch1G
    case IPodTouch2G
    case IPodTouch3G
    case IPodTouch4G
    case IPodTouch5G
    
    case IPad
    case IPad2
    case IPad3
    case IPad4
    case IPadMini
    case IPadMiniRetina
    case IPadMini3
    
    case IPadAir
    case IPadAir2
    
    case Simulator
}

func parseDeviceType(identifier: String) -> DeviceType {
    
    if identifier == "i386" || identifier == "x86_64" {
        return .Simulator
    }
    
    switch identifier {
    case "iPhone1,1": return .IPhone2G
    case "iPhone1,2": return .IPhone3G
    case "iPhone2,1": return .IPhone3GS
    case "iPhone3,1", "iPhone3,2", "iPhone3,3": return .IPhone4
    case "iPhone4,1": return .IPhone4S
    case "iPhone5,1", "iPhone5,2": return .IPhone5
    case "iPhone5,3", "iPhone5,4": return .IPhone5C
    case "iPhone6,1", "iPhone6,2": return .IPhone5S
    case "iPhone7,1": return .IPhone6Plus
    case "iPhone7,2": return .IPhone6
        
    case "iPod1,1": return .IPodTouch1G
    case "iPod2,1": return .IPodTouch2G
    case "iPod3,1": return .IPodTouch3G
    case "iPod4,1": return .IPodTouch4G
    case "iPod5,1": return .IPodTouch5G
        
    case "iPad1,1", "iPad1,2": return .IPad
    case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4": return .IPad2
    case "iPad2,5", "iPad2,6", "iPad2,7": return .IPadMini
    case "iPad3,1", "iPad3,2", "iPad3,3": return .IPad3
    case "iPad3,4", "iPad3,5", "iPad3,6": return .IPad4
    case "iPad4,1", "iPad4,2", "iPad4,3": return .IPadAir
    case "iPad4,4", "iPad4,5", "iPad4,6": return .IPadMiniRetina
    case "iPad4,7", "iPad4,8": return .IPadMini3
    case "iPad5,3", "iPad5,4": return .IPadAir2
        
    default: return .NotAvailable
    }
}

extension UIDevice {
    
    var deviceType: DeviceType {
        var systemInfo = utsname()
        uname(&systemInfo)
        
        let machine = systemInfo.machine
        
        let mirror = reflect(machine)//Mirror(reflecting: machine)
        
        var identifier = ""
        
        for i in 0..<mirror.count {
            if let value = mirror[i].1.value as? Int8 where value != 0 {
                identifier.append(UnicodeScalar(UInt8(value)))
            }
        }
        return parseDeviceType(identifier)
    }
    
    class func isIphone5() -> Bool
    {
      
        switch UIDevice.currentDevice().deviceType
        {
            case .IPhone5, .IPhone5C, .IPhone5S:
                return true
        case .Simulator:
                return UIScreen.instancesRespondToSelector("currentMode") ? CGSizeEqualToSize(CGSizeMake(640, 1136), UIScreen.mainScreen().currentMode!.size) : false
            default:
                return false
        }
    }
    
    class func isIphone6() -> Bool
    {
        switch UIDevice.currentDevice().deviceType
        {
        case .IPhone6:
            return true
        case .Simulator:
            return UIScreen.instancesRespondToSelector("currentMode") ? CGSizeEqualToSize(CGSizeMake(750, 1334), UIScreen.mainScreen().currentMode!.size) : false
        default:
            return false
        }
    }
    
    class func isIphone6p() -> Bool
    {
        switch UIDevice.currentDevice().deviceType
        {
        case .IPhone6Plus:
            return true
        case .Simulator:
            return UIScreen.instancesRespondToSelector("currentMode") ? CGSizeEqualToSize(CGSizeMake(1242, 2208), UIScreen.mainScreen().currentMode!.size) : false
        default:
            return false
        }
    }
    
    /* 屏幕宽度 */
    class func screenWidth() -> CGFloat {
        return UIScreen.mainScreen().bounds.size.width;
    }
    
    /* 屏幕高度 */
    class func screenHeight() -> CGFloat {
        return UIScreen.mainScreen().bounds.size.height;
    }
    
}