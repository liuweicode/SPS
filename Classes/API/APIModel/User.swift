//
//  User.swift
//  isflyer
//
//  Created by 楼顶 on 15/5/11.
//  Copyright (c) 2015年 楼顶. All rights reserved.
//

import UIKit
import JSONHelper

enum UserGender : Int
{
    case unknown = 0
    case Male = 1
    case Female = 2
}

class User: NSObject, Deserializable {
    
    var accountId:Int?                              //用户ID
    var nickname:String?                            //用户昵称
    var gender : UserGender = .Female               //用户性别，默认为0
    var accountheadpic:String?                      //用户头像地址
    
    required init(data: [String : AnyObject]) {
        accountId <-- data["account_id"]
        nickname <-- data["nickname"]
        var g:Int?
        g <-- data["gender"]
        gender = UserGender(rawValue: g!)!
        accountheadpic <-- data["account_headpic"]
    }
    
    override init()
    {
        super.init()
    }
}
