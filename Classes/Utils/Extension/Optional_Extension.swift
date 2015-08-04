//
//  Optional_Extension.swift
//  JuMiHang
//
//  Created by 刘伟 on 3/30/15.
//  Copyright (c) 2015 Louding. All rights reserved.
//

import Foundation

extension Optional {
    
    func defaultValue(defaultValue: T) -> T {
        switch(self) {
        case .None:
            return defaultValue
        case .Some(let value):
            return value
        }
    }
    
}