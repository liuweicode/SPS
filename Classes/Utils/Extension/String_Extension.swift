//
//  String_Extension.swift
//  JuMiHang
//
//  Created by 刘伟 on 3/26/15.
//  Copyright (c) 2015 Louding. All rights reserved.
//

import Foundation

extension String {
    
    subscript (i: Int) -> String
        {
            return String(Array(self)[i])
    }
    
    subscript (r: Range<Int>) -> String
        {
            var start = advance(startIndex, r.startIndex)
            var end = advance(startIndex, r.endIndex)
            return substringWithRange(Range(start: start, end: end))
    }
    
    
}