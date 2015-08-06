//
//  UserAPIManger.swift
//  isflyer
//
//  Created by 楼顶 on 15/6/29.
//  Copyright (c) 2015年 楼顶. All rights reserved.
//

import Foundation


class UserAPIManger : BaseAPIManager {
    
    // MARK:-  修改用户资料
    class func api_s_editaccount(#uid:Int,token:String, success:()->Void, relogin:()->Void,failed:(error:APIError)->Void){
        
        var params: [String : AnyObject] = [
            "uid" : "\(uid)",
            "token": token
        ]
        
        POST(Config.getApiURL("/api/s/editaccount"), params: params, success: { (responseData) -> Void in
            success()
        }, relogin: { () -> Void in
            relogin()
        }) { (error) -> Void in
            failed(error: error)
        }
    }
    
   
}
