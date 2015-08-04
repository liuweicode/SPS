//
//  DirectoryUtils.swift
//  Yilicai
//
//  Created by Apple5 on 15/1/20.
//  Copyright (c) 2015年 Louding. All rights reserved.
//

import UIKit

class DirectoryUtils: NSObject {
   
    class var documentsDirectory: NSURL {
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.endIndex-1] as! NSURL
    }
    
    class var cacheDirectory: NSURL {
        let urls = NSFileManager.defaultManager().URLsForDirectory(.CachesDirectory, inDomains: .UserDomainMask)
        return urls[urls.endIndex-1] as! NSURL
    }
     
}
