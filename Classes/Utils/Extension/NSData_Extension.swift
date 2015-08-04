//
//  NSData_Extension.swift
//  JuMiHang
//
//  Created by 刘伟 on 3/26/15.
//  Copyright (c) 2015 Louding. All rights reserved.
//

import Foundation


extension NSData
{
    func toBytes() -> [UInt8] {
        let count = self.length / sizeof(UInt8)
        var bytesArray = [UInt8](count: count, repeatedValue: 0)
        self.getBytes(&bytesArray, length:count * sizeof(UInt8))
        return bytesArray
    }
    
    //TODO 与上面那个方法相比 哪个更好？
    func swiftByteArray()->[UInt8]
    {
        var bytes = [UInt8](count:self.length, repeatedValue: 0)
        CFDataGetBytes(self, CFRangeMake(0, self.length), &bytes)
        return bytes
    }
}